class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to(request.referrer || feed_path)
    else
      flash[:alert] = "Please enter content before saving comment"
      redirect_to(request.referrer || feed_path)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(content: params[:comment][:content])
    redirect_to feed_path
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to(request.referrer || feed_path)
  end

  def comment_params
    params.permit(:content, :post_id)
  end
end
