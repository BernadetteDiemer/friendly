require 'date'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :index]


  def index
    policy_scope(Event)
  end

  def show
    @reviews = Review.joins(booking: :event).where('events.user_id': @user.id).where('bookings.status': 1)
  end

  def update
    if @user == current_user
      @user.update(user_params)
      redirect_to profile_path(@user)
    end
  end

  def pastbookings
    policy_scope(Booking)
  end

  private

  def user_params
    params.require(:user).permit(:about, :first_name, :last_name, :photo, :birthday, :gender, :languages)
  end

  def set_user
    @user = User.find(params[:user_id])
    authorize @user
  end

end
