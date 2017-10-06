class EventsController < ApplicationController

  def index
    @events_page = true
    @events = Event.all
  end

end
