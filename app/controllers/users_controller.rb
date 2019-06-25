class UsersController < ApplicationController
  include SessionsHelper

  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "signup_success"
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_delete_success"
    else
      flash[:danger] = t "user_delete_fail"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "user_not_exists"
    redirect_to root_path
  end

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?

    store_url_back_location
    flash[:danger] = t "please_login"
    redirect_to login_path
  end

  # Confirm the correct user
  def correct_user
    redirect_to root_path unless current_user? @user
  end

  # Confirms an admin user.
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
