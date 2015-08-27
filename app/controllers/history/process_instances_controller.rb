class History::ProcessInstancesController < ApplicationController
  before_filter :check_authenticate
  include ActivitiRawRequestsHelper

  def show
    @instances = HistoryProcessInstance.all('processInstanceId' => params[:id], 'includeProcessVariables' => true).data.to_a
    if @instances.first
      @process_instance = @instances.first
      @variables        = @process_instance.variables.to_a
      sub_processes_params = { superProcessInstanceId: @process_instance.id }
      # TODO: make constants or config params for 1 and 10
      sub_processes_params[:start] = (params[:sub_processes_page].to_i - 1) * 10 if params[:sub_processes_page]
      @sub_processes    = HistoryProcessInstance.paginate(:all, sub_processes_params, page: params[:sub_processes_page])
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