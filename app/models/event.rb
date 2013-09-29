class Event
  def self.all
    app = FbGraph::Application.new( CLIENT_ID, secret: CLIENT_SECRET)
    FbGraph::Page.new('uvicgamedev').fetch(access_token: app.access_token).events
  end
end
