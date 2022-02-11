class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post has been successfully created!"
    else
      flash[:alert] = "Post wasn't saved. The description s empty."
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
