class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :home, :index]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = policy_scope(Event).order(date: :asc)

    if params[:query].present? || params[:date].present?
      @events = Event.search_by_address_and_date("#{params[:query]} #{params[:date]}")
    else
      @events = policy_scope(Event).order(date: :asc)
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
    if @event.user.birthday
      @age = ((Time.zone.now - @event.user.birthday.to_time) / 1.year.seconds).floor
    end
  end

  def create
    @event = Event.new(events_params)
    @event.user = current_user
    authorize @event
    if @event.save
      Chatroom.create(event_id: @event.id)
      redirect_to event_path(@event)
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
    params.require(:event).permit(:title, :description, :number_of_participants, :address, :date, :photo, :languages, :event_type_id)
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
