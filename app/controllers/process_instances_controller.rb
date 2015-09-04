class ProcessInstancesController < ApplicationController
  before_filter :check_authenticate
  layout false, only: [:diagram_box, :diagram]
  include ActivitiRawRequestsHelper

  def index
    @process_instances = ProcessInstance.all
  end

  def show
    @instances = ProcessInstance.all(id: params[:id], 'includeProcessVariables' => true).to_a
    if @instances.first
      @process_instance = @instances.first
      history_instance  = HistoryProcessInstance.all('processInstanceId' => @process_instance.id).data.to_a.first
      @variables        = @process_instance.variables.to_a.sort_by { |h| h[:name].to_s.downcase }
      @jobs             = Job.all('processInstanceId' => @process_instance.id).to_a.sort_by { |h| h[:id].to_i }
      @tasks            = Task.all('processInstanceId' => @process_instance.id).to_a.sort_by { |h| h[:id].to_i }
      sub_processes_params = { superProcessInstanceId: @process_instance.id }
      # TODO: make constants or config params for 1 and 10
      sub_processes_params[:start] = (params[:sub_processes_page].to_i - 1) * 10 if params[:sub_processes_page]
      @sub_processes    = HistoryProcessInstance.paginate(:all, sub_processes_params, page: params[:sub_processes_page])
      @super_process_id = history_instance.superProcessInstanceId
      @start_time       = Time.parse(history_instance.startTime)
    else
      redirect_to history_process_instance_path id: params[:id]
    end
  end

  def destroy
    ProcessInstance.destroy(params[:id])
    flash[:success] = "Process instance #{params[:id]} has been removed."
    redirect_to root_path
  end

  def search
    redirect_to process_instance_path id: params[:id]
  end

  def diagram
    url = "#{session[:api_url]}runtime/process-instances/#{params[:id]}/diagram"
    send_data raw_request(url), type: 'image/png' , disposition: 'attachment'
  end

  def diagram_box
  end
end
