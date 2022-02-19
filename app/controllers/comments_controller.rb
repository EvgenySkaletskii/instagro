class CommentsController < ApplicationController
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.update(content: params[:comment][:content])
    redirect_to feed_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to(request.referrer || feed_path)
  end

  def comment_params
    params.permit(:content, :post_id)
  end
end
