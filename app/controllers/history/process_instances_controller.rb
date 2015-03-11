class History::ProcessInstancesController < ApplicationController
  before_filter :check_authenticate
  include ActivitiRawRequestsHelper

  def show
    @instances = HistoryProcessInstance.all('processInstanceId' => params[:id], 'includeProcessVariables' => true).to_a
    if @instances.first
      @process_instance = @instances.first
      @variables        = @process_instance.variables.to_a
      @sub_processes    = HistoryProcessInstance.all('superProcessInstanceId' => @process_instance.id).to_a
      @super_process_id = @process_instance.superProcessInstanceId
      @start_time       = Time.parse(@process_instance.startTime)
      @end_time         = Time.parse(@process_instance.endTime) if @process_instance.endTime
      @is_history       = true
      render 'process_instances/show'
    else
      @id = params[:id]
      render 'process_instances/not_found', status: 404
    end
  end
end