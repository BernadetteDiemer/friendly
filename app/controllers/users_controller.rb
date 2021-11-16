require 'date'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def show
    @user = User.find(params[:user_id])
    if @user.birthday
      @age = ((Time.zone.now - @user.birthday.to_time) / 1.year.seconds).floor
    end
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to profile_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:about, :first_name, :last_name)
  end
end
