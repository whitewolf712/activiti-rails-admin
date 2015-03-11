class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :provide_session_to_rest_client

  protected
  def provide_session_to_rest_client
    accessor = instance_variable_get(:@_request)
    ActivitiAbstractModel.send(:define_method, 'session', proc {accessor.session})
    Engine.send(:define_method, 'session', proc {accessor.session} )
    begin
      yield
    rescue ActiveRestClient::HTTPUnauthorisedClientException
      session[:login_redirect_url] = request.url
      flash[:error] = 'You need to authorize'
      redirect_to new_session_path
    ensure
       ActivitiAbstractModel.send(:remove_method, 'session')
    end
  end

  def check_authenticate
    redirect_to new_session_path unless session[:api_url]
  end
end
