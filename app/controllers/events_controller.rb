class EventsController < ApplicationController
  def index
    @events = policy_scope(Event).order(created_at: :desc)
  end
end
