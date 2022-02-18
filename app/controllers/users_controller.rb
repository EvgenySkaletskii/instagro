class UsersController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @users = User.all_except(current_user)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = current_user.posts.build if user_signed_in?
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "Profile has been successfully updated"
      sign_in(current_user, :bypass => true)
      redirect_to current_user
    else
      flash[:alert] = "Please fill all required fields with valid values"
      redirect_to edit_user_path(current_user)
    end
  end

  def followers
    @user = User.find(params[:id])
    @title = current_user == @user ? "Your followers:" : "Followers:"
    @users = @user.followers
    render "show_follows"
  end

  def following
    @title = current_user == @user ? "Your followings:" : "Followings:"
    @user = User.find(params[:id])
    @users = @user.following
    render "show_follows"
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :about, :password, :password_confirmation)
  end

  def record_not_found
    flash[:alert] = "Please do not type parameters manually"
    redirect_to feed_path
  end
end
