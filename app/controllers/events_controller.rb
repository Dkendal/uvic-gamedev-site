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
    flash[:success] = t '.destroy.success'
    redirect_to Event
  end

  def create
    @event = Event.new event_params
    if @event.save
      flash[:danger] = t '.create.success'
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
      flash[:success] = t '.update.success'
      redirect_to @event
    else
      flash[:success] = t '.update.failure'
      render :edit
    end
  end

  private

  def event_doesnt_exist exception
    if exception.error_code == 100
      @event.delete
      flash[:error] = t '.event_doesnt_exist'
      redirect_to Event
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
