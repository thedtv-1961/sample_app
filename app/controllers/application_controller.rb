class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def logged_in_user
    return if logged_in?

    store_url_back_location
    flash[:danger] = t "please_login"
    redirect_to login_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
