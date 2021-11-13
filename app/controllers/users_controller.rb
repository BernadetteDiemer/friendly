require 'date'

class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    if @user.birthday
     @age = ((Time.zone.now - @user.birthday.to_time) / 1.year.seconds).floor
    end
    authorize @user
  end

  def update
    @user.update(user_params)
    redirect_to profile_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:about)
  end
end
