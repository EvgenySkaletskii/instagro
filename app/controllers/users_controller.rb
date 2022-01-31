class UsersController < ApplicationController
  def index
    #show user's posts
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to current_user, notice: "Profile has been successfully updated!"
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
