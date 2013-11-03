class EventsController < ApplicationController
  load_resource except: :create
  authorize_resource
  layout 'application'

  rescue_from FbGraph::InvalidRequest, with: :event_doesnt_exist

  def index
    @events = Event.where user: current_user
  end

  def show
    @event = FbGraph::Event.new(@event.id).fetch(access_token: Token.app_token)
  end

  def new
    @event = Event.new
  end

  def destroy
    @event.destroy
    flash[:success] = t '.success'
    redirect_to Event
  end

  def create
    @event = Event.new event_params
    if @event.save
      flash[:success] = t '.success'
      redirect_to @event
    else
      flash[:danger] = t '.failure'
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update event_params
      flash[:success] = t '.success'
      redirect_to @event
    else
      flash[:danger] = t '.failure'
      render :edit
    end
  end

  private

  def event_doesnt_exist exception
    case exception.error_code
    when 100
      # object doesn't exist... hopefully this is the closest thing that fb
      # gives us to an explicity 'object doesn't exist error
      @event.delete
      flash[:error] = t '.event_doesnt_exist'
      redirect_to Event
    when 1588016
      # invalid attribute error, likely 'end date can't be before start date'
      flash[:danger] = exception # TODO add better error text
      redirect_to :back
    else
      throw exception
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
      :end_date
    )
  end
end
