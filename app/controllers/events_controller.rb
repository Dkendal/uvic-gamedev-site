class EventsController < ApplicationController
  respond_to :js
  def index
    @events = Event.all
    render 'index', layout: false
  end

  def new
  end
end
