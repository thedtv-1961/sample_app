class StaticPagesController < ApplicationController
  include SessionsHelper

  def home
    return unless logged_in?

    @micropost = current_user.microposts.build if logged_in?
    @feed_items = current_user.microposts.newest.paginate page: params[:page],
      per_page: Settings.micropost_per_page
  end

  def help; end

  def about; end

  def contact; end
end
