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
    if current_user.update(user_params)
      flash[:notice] = "Profile has been successfully updated"
      sign_in(current_user, :bypass => true)
      redirect_to current_user
    else
      flash[:alert] = "Please fill all required fields with valid values"
      redirect_to edit_user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :about, :password, :password_confirmation)
  end
end
