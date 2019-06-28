class SessionsController < ApplicationController

  before_action :check_user_logged_in, except: :destroy

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      user_not_activated params[:session][:remember_me], user
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
      remember user
    else
      forget user
    end
  end

  def user_not_activated checked, user
    unless user.activated?
      flash[:warning] = t "account_not_activated"
      return redirect_to root_path
    end
    flash[:success] = t "login_success"
    remember_me_checked checked, user
    redirect_back_or user
  end
end
