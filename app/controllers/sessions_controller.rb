class SessionsController < ApplicationController
  include SessionsHelper

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      flash[:success] = t "login_success"
      remember_me_checked params[:session][:remember_me], user
      redirect_back_or user
    else
      flash[:danger] = t "login_fail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def remember_me_checked checked, user
    log_in user
    if checked == Settings.remember_me_checked
      remember(user)
    else
      forget(user)
    end
  end
end
