class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :create
  before_action :load_relationship, only: :destroy

  def create
    current_user.follow @user
    # redirect_to @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow @user
    # redirect_to @relationship.followed
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:followed_id]
    user_params_invalid @user
  end

  def load_relationship
    @relationship = Relationship.find_by id: params[:id]
    user_params_invalid @relationship
  end

  def user_params_invalid user
    unless user
      flash[:warning] = t "user_not_exists"
      redirect_to root_path
    end

  end
end
