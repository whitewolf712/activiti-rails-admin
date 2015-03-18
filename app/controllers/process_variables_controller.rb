class ProcessVariablesController < ApplicationController
  before_filter :check_authenticate
  include ActivitiRawRequestsHelper

  def update
    @variable = ProcessVariable.find process_instance_id: params[:id], name: params[:name]
    @variable.value = params['undefined']['value']
    @variable.save process_instance_id: params[:id], name: params[:name]
    render json: { status: 'OK' }
  end

  def data
    url = "#{session[:api_url]}runtime/process-instances/#{params[:id]}/variables/#{params[:name]}/data"
    send_data raw_request(url), type: 'application/x-java-serialized-object' , disposition: 'inline'
  end
end
