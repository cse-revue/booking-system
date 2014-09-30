class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:user_session_key].nil?
      nil
    else
      User.find_by session_key: session[:user_session_key]
    end
  end

  helper_method :current_user
end
