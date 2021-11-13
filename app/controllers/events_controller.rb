class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :home, :index]
  before_action :set_event, only: [:show]

  def index
    @events = policy_scope(Event).order(created_at: :desc)

    if params[:query].present?
      @events = Event.search_by_address_and_date(params[:query])
    else
      @events = policy_scope(Event).order(created_at: :desc)
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
  end


  def create
    raise
    @event = Event.new(event_params)
    @event.user = current_user
    authorize @event
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end


  private

  def event_params
    params.require(:event).permit(:title, :description, :number_of_participants, :address, :date, :languages, :photo)
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
