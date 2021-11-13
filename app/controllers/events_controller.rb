class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :home, :index]
  before_action :set_event, only: [:show]

  def index
    @events = policy_scope(Event).order(created_at: :desc)
  end

  def show
    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude
    }]
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
