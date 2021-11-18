class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    policy_scope(Booking)
  end

  def new
    @booking = Booking.new
    @event = Event.find(params[:event_id])
    authorize @booking
  end

  def show
    @event = Event.find(params[:event_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    event = Event.find(params[:event_id])
    @booking.event = event
    @booking.status = "pending"
    authorize @booking
    if @booking.save!
      redirect_to new_event_booking_path(event)
    else
      render :show
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    authorize @booking
    redirect_to event_path(id: params[:event_id])
  end

  private

  def booking_params
    params.require(:event_id) && params.permit(:message, :status)
  end
end
