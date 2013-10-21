class Event
  include ActiveModel::Naming
  include ActiveModel::Model
  include ActiveModel::Validations

  validates_presence_of :name, :start_date

  attr_accessor(:name,
                :description,
                :start_date,
                :start_time,
                :has_end,
                :end_date,
                :end_time,
                :picture,
                :location)

  def self.all
    app = FbGraph::Application.new( CLIENT_ID, secret: CLIENT_SECRET)
    FbGraph::Page.new('uvicgamedev').
      fetch(access_token: app.access_token).events
  end

  def self.initialize attributes = {}
    attributes.each do |name, value|
      send "#{name}=", value
    end
  end

  def save
    page = FbGraph::Page.new('uvicgamedev')
    page.access_token = Token.first.token
    page.event! to_hash
  end

  def starts
    DateTime.parse "#{start_date} #{start_time}" if start_date
  end

  def ends
    DateTime.parse "#{end_date} #{end_time}" if end_date
  end

  def to_hash
    {
      name: name,
      description: description,
      start_time: starts,
      end_time: ends,
      location: location,
      picture: picture,
      access_token: Token.first.token
    }
  end
end
