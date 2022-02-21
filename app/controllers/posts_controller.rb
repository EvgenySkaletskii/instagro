class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post has been successfully created!"
    else
      flash[:alert] = "Post wasn't saved. #{@post.errors.full_messages.first}"
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
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update(post_params)
      flash[:notice] = "Post has been successfully updated!"
    else
      flash[:alert] = "Post wasn't saved. #{@post.errors.full_messages.first}"
    end
    redirect_to feed_path
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
