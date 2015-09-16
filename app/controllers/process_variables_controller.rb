class ProcessVariablesController < ApplicationController
  before_filter :check_authenticate
  include ActivitiRawRequestsHelper

  def update
    @variable = ProcessVariable.find process_instance_id: params[:id], name: params[:name]
    @variable.value = params['undefined']['value']
    @variable.save process_instance_id: params[:id], name: params[:name]
    render json: { status: 'OK' }
  end

  def update_binary
    @url = "#{session[:api_url]}runtime/process-instances/#{params[:id]}/variables/#{params[:name]}"
    @file =  params['file']
    @variable = ProcessVariable.find process_instance_id: params[:id], name: params[:name]

    put_binary_variable_data @url, params[:name], @variable.type, @file.tempfile
    File::delete(@file.tempfile.path) if File::exists?(@file.tempfile.path)

    # TODO: Handle exceptions and unsuccess api responses. Send messages to flash
    flash[:success] = 'Binary data uploaded succesfully'
    redirect_to process_instance_path(params[:id])
  end

  def data
    url = "#{session[:api_url]}runtime/process-instances/#{params[:id]}/variables/#{params[:name]}/data"
    send_data raw_request(url), type: 'application/x-java-serialized-object' , disposition: 'inline'
  end
end
