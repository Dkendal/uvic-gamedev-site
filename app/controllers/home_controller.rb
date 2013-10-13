class HomeController < ApplicationController
  skip_authorization_check
  layout 'events'

  def index
  end
end
