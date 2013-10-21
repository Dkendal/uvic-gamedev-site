class EventsController < ApplicationController
  authorize_resource
  layout 'application'

  respond_to :js
  def index
    @events = Event.all
    render 'index', layout: false
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    if @event.save
      redirect_to @event
    else
      flash[:danger] = "something has gone terribly wrong!"
      render :new
    end
  end

  def event_params
    params.require(:event).permit(:name,
                                  :start_date,
                                  :description,
                                  :start_time,
                                  :end_time,
                                  :end_date)
    params.require(:event).tap do |e|
      e.require(:name)
      e.require(:start_date)
      e.require(:end_date) if e[:end_time]
      e.require(:end_time) if e[:end_date]
      e.require(:start_time) if e[:end_date]
    end
  end
end
