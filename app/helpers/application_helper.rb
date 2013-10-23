module ApplicationHelper
  def cache_key_fb_events
    Time.now.strftime '%Y-%m-%d-%H-%M'
  end
end
