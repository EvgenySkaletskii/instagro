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
  end

  def update
  end

  def destroy
  end

  def comment_params
    params.permit(:content, :post_id)
  end
end
