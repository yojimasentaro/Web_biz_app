class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    current_user.update(update_params)
    redirect_to root_path, notice: 'Updated Successfully!'
  end

  private
  def update_params
    params.require(:user).permit(
      :username,
      :avatar,
      :email,
      :password,
      :profile,
      :member,
      :works,
      :photographer_flg,
      :model_flg,
      :camera
      )
  end
end
