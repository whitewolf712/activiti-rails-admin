class ProcessInstancesController < ApplicationController
  before_filter :check_authenticate
  include ActivitiRawRequestsHelper

  def index
    @process_instances = ProcessInstance.all
  end

  def show
    @instances = ProcessInstance.all(id: params[:id], 'includeProcessVariables' => true).to_a
    if @instances.first
      @process_instance = @instances.first
      history_instance  = HistoryProcessInstance.all('processInstanceId' => @process_instance.id).to_a.first
      @variables        = @process_instance.variables.to_a.sort_by { |h| h[:name].to_s.downcase }
      @jobs             = Job.all('processInstanceId' => @process_instance.id).to_a.sort_by { |h| h[:id].to_i }
      @tasks            = Task.all('processInstanceId' => @process_instance.id).to_a.sort_by { |h| h[:id].to_i }
      @sub_processes    = HistoryProcessInstance.all('superProcessInstanceId' => @process_instance.id).to_a
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
    send_data raw_request(url), type: 'image/png' , disposition: 'inline'
  end

  def diagram_box
  end
end
