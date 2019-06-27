class PasswordResetsController < ApplicationController
  include SessionsHelper

  before_action :load_user, :valid_user, :check_expiration,
    only: %i(edit update)
  before_action :check_email, only: :create

  def new; end

  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t "email_reset_password_sent"
    redirect_to root_path
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("txt_pwd_can_not_empty")
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t "password_has_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:warning] = t "user_not_exists"
    redirect_to root_path
  end

  def valid_user
    unless @user.activated? &&
           @user.authenticated?(:reset, params[:id])
      redirect_to root_path
    end
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "password_reset_expired"
    redirect_to new_password_reset_path
  end

  def check_email
    @user = User.find_by email: params[:password_reset][:email]
    return if @user

    flash.now[:danger] = t "email_addr_not_found"
    return render :new
  end
end
