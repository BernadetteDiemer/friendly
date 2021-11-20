require 'date'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :index]


  def index
    policy_scope(Event)
  end

  def show
    @review = current_user.reviews.last
    @reviews = current_user.reviews
    reviewed_user = @review.booking.event.user_id
    # @reviews = Review.joins(:bookings).where(bookings: { id: @review.booking_id}).joins(:events).where(events: { user_id: reviewed_user})
    @bookings = current_user.bookings
    if @user.birthday
      @age = ((Time.zone.now - @user.birthday.to_time) / 1.year.seconds).floor
    end
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
    params.require(:user).permit(:about, :first_name, :last_name, :photo)
  end

  def set_user
    @user = User.find(params[:user_id])
    authorize @user
  end

end
