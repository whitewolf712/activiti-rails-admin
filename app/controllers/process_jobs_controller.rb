class ProcessJobsController < ApplicationController
  before_filter :check_authenticate
  include ActivitiRawRequestsHelper

  def index
    @jobs = Job.find_all process_instance_id: params[:id]
  end

  def stacktrace
    url = "#{session[:api_url]}management/jobs/#{params[:id]}/exception-stacktrace"
    @trace = raw_request(url)
  end

  def update
    begin
      Job.execute id: params[:id]
      flash[:success] = 'Job execute successful.'
    rescue ActiveRestClient::HTTPServerException => e
      flash[:error] = 'Job execute failed. Internal server error. See exception message on job for details.' if e.status == 500
    ensure
      redirect_to :back
    end
  end

  def destroy
    Job.remove id: params[:id]
    flash[:success] = 'Job remove successful.'
    redirect_to :back
  end
end
