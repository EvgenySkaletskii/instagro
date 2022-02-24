class PageController < ApplicationController
  def feed
    if user_signed_in?
      @user = current_user
      @post = current_user.posts.build
      @comment = current_user.comments.build
      #show posts logic
      if @user.member?
        @feed_items = current_user.feed
      else
        @feed_items = Post.all
      end
    end
  end

  def about
  end
end
