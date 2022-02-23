class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post has been successfully created!"
    else
      flash[:alert] = "Post wasn't saved. #{@post.errors.full_messages.first}"
    end
    redirect_to feed_path
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post has been successfully updated!"
      redirect_to feed_path
    else
      flash[:alert] = "Post wasn't saved. #{@post.errors.full_messages.first}"
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post has been successfully deleted!"
    redirect_to request.referrer || feed_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
