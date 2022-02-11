class PageController < ApplicationController
  # def index
  #   if signed_in?
  #     redirect_to home_path
  #   end
  # end

  def home
    @post = current_user.posts.build if user_signed_in?
  end
end
