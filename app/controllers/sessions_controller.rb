class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Login successfully"
      log_in user
      remember user
      redirect_to root_path
    else
      flash[:danger] = "Login fail"
      render :new
    end

  end

  def destroy
    logout
    redirect_to root_path
  end
end
