class Users::AuthController < ApplicationController
  skip_authorization_check
  def facebook
    request.env['omniauth.strategy'].options.scope = "email" || session[:fb_permissions]
    render text: 'Omniauth setup phase.', status: 404
  end
  def skip_protect_from_forgery?
    true
  end
end
