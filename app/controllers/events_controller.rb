class EventsController < ApplicationController

  # GET /events
  # GET /events.json
  def index
    @events_page = true
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
  end

end
