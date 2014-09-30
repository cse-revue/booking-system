require 'securerandom'

class UserController < ApplicationController

  def user_signup_params
    params.require(:user).permit(:name, :email, :phone, :new_password, :new_password_confirmation)
  end

  def signup
    render layout: 'admin'
  end
  
  def do_signup
    User.create user_signup_params
    redirect_to "/user/login"
  end

  def user_login_params
    params.require(:user).permit(:email, :password)
  end

  def login
    render layout: 'admin'
  end

  def do_login
    user = User.authenticate(user_login_params[:email], user_login_params[:password])
    key = SecureRandom.hex
    session[:user_session_key] = key
    user.session_key = key
    user.save
    redirect_to "/user"
  end

  def logout
    user = current_user
    user.session_key = ''
    user.save
    redirect_to "/user/login"
  end

  def reset
  end

  def modify
  end

  def index
    if !session[:user_session_key]
      return redirect_to "/user/login"
    else
      @user = current_user
    end

    render layout: 'admin'
  end

end
