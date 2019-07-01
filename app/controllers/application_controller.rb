class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  private

  def logged_in_user
    return if logged_in?

    store_url_back_location
    flash[:danger] = t "please_login"
    redirect_to login_path
  end

  def check_user_logged_in
    return redirect_to root_path if logged_in?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def render_not_found
    render file: "public/404.html", layout: false, status: :not_found
  end

end
