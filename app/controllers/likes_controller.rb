class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.likes.create(like_params)
    redirect_to request.referrer
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to request.referrer
  end

  private

  def like_params
    params.permit(:likable_id, :likable_type)
  end
end
