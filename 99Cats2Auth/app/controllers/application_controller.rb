class ApplicationController < ActionController::Base
  #before_action :verify_authenticity_token

  
  helper_method :current_user, :logged_in?
  
  #before_action :require_logged_in, except: [:new, :create]

  def require_logged_in
    redirect_to user_url unless logged_in?
  end


  
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
