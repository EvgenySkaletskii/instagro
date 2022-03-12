class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followers, :following]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @users = User.all_except(current_user)
  end

  def show
    @posts = @user.posts
    @post = current_user.posts.build
    @comment = current_user.comments.build
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile has been successfully updated"
      sign_in(@user, :bypass => true)
      redirect_to @user
    else
      flash[:alert] = "Please fill all required fields with valid values"
      redirect_to edit_user_path(@user)
    end
  end

  def followers
    @title = current_user == @user ? "Your followers:" : "Followers:"
    @users = @user.followers
    render "show_follows"
  end

  def following
    @title = current_user == @user ? "Your followings:" : "Followings:"
    @users = @user.following
    render "show_follows"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :about, :password, :password_confirmation, :avatar)
  end

  def record_not_found
    flash[:alert] = "Please do not type parameters manually"
    redirect_to feed_path
  end
end
