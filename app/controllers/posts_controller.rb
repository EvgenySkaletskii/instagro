class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post has been successfully created!"
    else
      flash[:alert] = "Post wasn't saved. The description is empty."
    end
    redirect_to feed_path
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    @post.destroy
    flash[:notice] = "Post has been successfully deleted!"
    redirect_to request.referrer || feed_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    #authorize @post
    if @post.update(post_params)
      flash[:notice] = "Post has been successfully updated!"
    else
      flash[:alert] = "Incorrect value for post content"
    end
    redirect_to feed_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action. The post's owner has more than 10 posts!"
    redirect_to(request.referrer || root_path)
  end
end
