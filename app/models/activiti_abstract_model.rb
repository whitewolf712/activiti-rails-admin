class ActivitiAbstractModel < ActiveRestClient::Base
  before_request :prepare_request

  private
  def prepare_request(name, request)
    user      = session[:api_user].to_s
    password  = session[:api_password].to_s
    request.append_get_parameters if request.get_params.any?
    request.forced_url = session[:api_url].gsub(/\/$/, '') + '/' + request.url.gsub(/^\//, '')
    request.headers['Authorization'] = "Basic #{Base64.encode64("#{user}:#{password}").strip}"
  end
end
