class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post has been successfully created!"
    else
      flash[:alert] = "Post was not saved! Please use the correct parameters."
    end
    redirect_to current_user
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
