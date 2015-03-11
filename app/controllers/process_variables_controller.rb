class ProcessVariablesController < ApplicationController
  before_filter :check_authenticate

  def update
    @variable = ProcessVariable.find process_instance_id: params[:id], name: params[:name]
    @variable.value = params['undefined']['value']
    @variable.save process_instance_id: params[:id], name: params[:name]
    render json: { status: 'OK' }
  end
end
