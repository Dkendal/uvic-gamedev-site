class EventsController < ApplicationController
  skip_authorization_check only: :index
  load_and_authorize_resource

  layout 'application'

  respond_to :js
  def index
    @events = Event.all
    render 'index', layout: false
  end

  def new
  end

  def create
  end
end
