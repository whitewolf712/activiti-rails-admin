class SessionsController < ApplicationController
  def new
    if @api_url
      flash[:info] = 'You already signed in'
      begin
        redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to root_path
      end
    end
  end

  def create
    session[:api_user]      = params[:login]
    session[:api_password]  = params[:password]
    session[:api_url]       = params[:api_url]
    begin
      session[:api_version] = Engine.engine.version.to_s
      flash[:success] = 'Authorized successfully'
      redirect_to session.delete(:login_redirect_url) || root_path
    rescue ActiveRestClient::HTTPUnauthorisedClientException
      [:api_user, :api_password, :api_url].each { |key| session.delete key }
      flash[:error] = 'Wrong credentials'
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    flash[:success] = 'Signed out successfully'
    redirect_to signin_path
  end
end