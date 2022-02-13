class PageController < ApplicationController
  # def index
  #   if signed_in?
  #     redirect_to home_path
  #   end
  # end

  def feed
    if user_signed_in?
      @user = current_user
      @post = current_user.posts.build if user_signed_in?
      #show posts logic
      if @user.member?
        @feed_items = current_user.feed
      else
        @feed_items = Post.all
      end
    end
  end
end
