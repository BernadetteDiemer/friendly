class EventsController < ApplicationController
  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    authorize @event
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def index
    @events = policy_scope(Event).order(created_at: :desc)
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :number_of_participants, :address, :date, :languages)
  end
end
