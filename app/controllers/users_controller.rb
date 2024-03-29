class UsersController < ApplicationController

  before_action :check_user_logged_in, only: %i(new create)
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.user_activated.paginate page: params[:page],
      per_page: Settings.user_per_page
  end

  def show
    redirect_to root_path unless @user.activated?

    @microposts = @user.microposts.newest.paginate page: params[:page],
      per_page: Settings.micropost_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "please_check_your_email"
      redirect_to root_path
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

  def following
    @title = t "following"
    @users = @user.following.paginate(page: params[:page])
    render "users/show_follow"
  end

  def followers
    @title = t "follower"
    @users = @user.followers.paginate(page: params[:page])
    render "users/show_follow"
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

  # Confirm the correct user
  def correct_user
    redirect_to root_path unless current_user? @user
  end

  # Confirms an admin user.
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
