class EventsController < ApplicationController
  authorize_resource
  layout 'application'

  respond_to :js
  def index
    @events = Event.fetch
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
    params[:event][:user_id] = current_user.id
    params.require(:event).permit(:name,
                                  :start_date,
                                  :description,
                                  :location,
                                  :start_time,
                                  :end_time,
                                  :user_id,
                                  :end_date).tap do |e|
                                    e.require(:user_id)
                                    e.require(:name)
                                    e.require(:start_date)
                                    e.require(:end_date) if e[:end_time].present?
                                    e.require(:end_time) if e[:end_date].present?
                                    e.require(:start_time) if e[:end_date].present?
                                    e.require(:start_time) if e[:end_date].present?
                                  end
  end
end
