class EventsController < ApplicationController
  load_resource except: :create
  authorize_resource
  layout 'application'

  def index
    @events = Event.where user: current_user
  end

  def show
    @event = FbGraph::Event.new(@event.id).fetch(access_token: Token.app_token)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    if @event.save
      redirect_to @event
    else
      flash[:danger] = t '.create.failure'
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update event_params
      flash[:success] = t '.update/success'
      redirect_to @event
    else
      flash[:success] = t '.update/failure'
      render :edit
    end
  end

  def event_params
    params[:event][:user_id] = current_user.id
    params.require(:event).permit(
      :name,
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
      end
  end
end
