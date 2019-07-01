class MicropostsController < ApplicationController

  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.newest.build(micropost_params)
    flash[:success] = t "micropost_create_success" if @micropost.save
    redirect_to root_path
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "micropost_delete"
    else
      flash[:warning] = t "micropost_delete_fail"
    end
    redirect_to request.referrer || root_path
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_path unless @micropost
  end
end
