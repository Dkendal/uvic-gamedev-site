class EventsController < ApplicationController
  authorize_resource
  rescue_from FbGraph::Unauthorized, with: :escalate_permisions

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

  def escalate_permisions
    session[:fb_permissions].append(*[:create_event, :manage_pages])
    redirect_to '/auth/facebook'
  end
end
