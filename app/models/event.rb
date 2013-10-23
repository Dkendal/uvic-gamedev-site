class Event < ActiveRecord::Base
  belongs_to :user

  before_save :fb_save

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

  def self.fetch
    app = FbGraph::Application.new( CLIENT_ID, secret: CLIENT_SECRET)
    FbGraph::Page.new('uvicgamedev').
      fetch(access_token: app.access_token).events
  end

  def fb_save
    page = FbGraph::Page.new('uvicgamedev')
    page.access_token = Token.first.token
    event = page.event! to_hash
    self.id = event.raw_attributes['id']
  end

  def starts
    parse_date start_date, start_time
  end

  def ends
    parse_date end_date, end_time
  end

  private
    def parse_date date_str, time_str
      if date_str.present?
        datetime = DateTime.parse "#{date_str} #{time_str}"
        if time_str.present?
          datetime
        else
          datetime.to_date
        end
      end
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
