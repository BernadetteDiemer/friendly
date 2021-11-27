require 'date'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :index]


  def index
    policy_scope(Event)
  end

  def show
    @reviews = Review.joins(booking: :event).where('events.user_id': @user.id).where('bookings.status': 1)
    if @user.birthday
      @age = ((Time.zone.now - @user.birthday.to_time) / 1.year.seconds).floor
    end
    @average = average_rating(@reviews)
    @booking = Booking.new
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

  def average_rating(reviews)
    if reviews.blank?
      return 0
    else
      sum = 0
      reviews.each do |review|
        sum += review.rating
      end
      average = sum.to_f / reviews.length
      return average
    end
  end
end
