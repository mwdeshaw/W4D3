class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  #skip_before_action :verify_authenticity_token
  
  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_out!
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
    @current_user = nil
  end


end
