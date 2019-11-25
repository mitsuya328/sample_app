class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      render "static_pages/home_logged_in"
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
