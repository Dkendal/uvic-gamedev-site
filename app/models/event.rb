class Event
  include ActiveModel::Naming
  include ActiveModel::Model
  attr_accessor :name, :description, :start_time, :start_date, :end_time, :end_date, :location

  def self.all
    app = FbGraph::Application.new( CLIENT_ID, secret: CLIENT_SECRET)
    FbGraph::Page.new('uvicgamedev').
      fetch(access_token: app.access_token).events
  end
end
