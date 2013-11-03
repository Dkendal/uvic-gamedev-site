class Event < ActiveRecord::Base
  belongs_to :user

  validates :starts, timeliness: { before: :ends }, if: :ends
  validates :name, :start_date, presence: true
  validates :end_date, if: "end_time.present?", presence: true


  alias_method :identifier, :id

  before_create :fb_create
  before_update :fb_update
  before_destroy :fb_destroy

  attr_accessor(
    :name,
    :description,
    :start_date,
    :start_time,
    :has_end,
    :end_date,
    :end_time,
    :picture,
    :location
  )

  def self.fb_all
    FbGraph::Page.new('uvicgamedev').
      fetch(access_token: Token.app_token).events
  end

  def fetch
    FbGraph::Event.new(self.id).fetch access_token: Token.first.token
  end

  def fb_destroy
    event = fetch
    event.destroy
  end

  def fb_update
    event = fetch
    event.update to_hash
    self.touch
  end

  def fb_create
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
    case
    when date_str.present? && time_str.present?
      DateTime.strptime "#{date_str} #{time_str}", "%Y/%m/%e %H:%M"
    when date_str.present?
      Date.strptime date_str, "%Y/%m/%e"
    else
      nil
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
