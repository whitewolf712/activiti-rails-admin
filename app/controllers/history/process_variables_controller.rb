class History::ProcessVariablesController < ApplicationController
  before_filter :check_authenticate
  include ActivitiRawRequestsHelper

  def data
    url = "#{session[:api_url]}history/historic-process-instances/#{params[:id]}/variables/#{params[:name]}/data"
    send_data raw_request(url), type: 'application/x-java-serialized-object' , disposition: 'inline'
  end
end
