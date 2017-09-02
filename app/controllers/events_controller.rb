class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  # GET /events
  # GET /events.json
  def index
    @events_page = true
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

end
