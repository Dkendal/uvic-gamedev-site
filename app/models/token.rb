class Token < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :token

  def self.app_token
    app = FbGraph::Application.new( CLIENT_ID, secret: CLIENT_SECRET)
    app.access_token
  end
end
