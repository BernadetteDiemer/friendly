class ReviewsController < ApplicationController
  skip_after_action :verify_authorized
  before_action :set_event_booking, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.booking = @booking
    if @review.save
      redirect_to profile_path(@event.user)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_event_booking
    @event = Event.find(params[:event_id])
    @booking = Booking.find(params[:booking_id])
  end
end
