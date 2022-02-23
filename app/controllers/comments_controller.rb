class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def create
    @comment = current_user.comments.build(post_id: params[:post_id], content: params[:content])
    if @comment.save
      redirect_to(request.referrer || feed_path)
    else
      flash[:alert] = "Please enter content before saving comment"
      redirect_to(request.referrer || feed_path)
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment has been updated successfully"
      redirect_to feed_path
    else
      flash[:alert] = "Content can't be blank"
      redirect_to edit_post_path(@comment)
    end
  end

  def destroy
    @comment.destroy
    redirect_to(request.referrer || feed_path)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
