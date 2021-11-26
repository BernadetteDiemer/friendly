class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :home, :index]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = policy_scope(Event).order(created_at: :desc)

    if params[:query].present?
      @events = Event.search_by_address_and_date(params[:query])
    else
      @events = policy_scope(Event).order(created_at: :desc)
    end

    if params[:params1] == "today"
      @events = Event.search_by_date(Date.today)
    end

    if params[:params2] == "tomorrow"
      @events = Event.search_by_date(Date.tomorrow)
    end

    if params[:params3] == "soon"
      @events = Event.where(date: Date.today..1.week.from_now)
    end

  end

  def new
    @event = Event.new
    authorize @event
  end

  def show
    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude
    }]
    @booking = Booking.new
    @num_accepted_participants = @event.bookings.select { |invite| invite.status == "accepted" }.count
    if current_user != nil
      @matching_booking = current_user.bookings.select { |b| b.event.id == @event.id }.first
      @already_booked = !@matching_booking.nil?
    end
  end

  def create
    @events = Event.new(events_params)
    @events.user = current_user
    authorize @events
    if @events.save
      Chatroom.create({event_id: @events.id})
      redirect_to event_path(@events)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @event.update(events_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def events_params
    params.require(:event).permit(:title, :description, :number_of_participants, :address, :date, :languages, :photo)
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
