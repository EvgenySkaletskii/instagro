class PageController < ApplicationController
  # def index
  #   if signed_in?
  #     redirect_to home_path
  #   end
  # end

  def feed
    if user_signed_in?
      @post = current_user.posts.build if user_signed_in?
      @feed_items = current_user.feed
    end
  end
end
