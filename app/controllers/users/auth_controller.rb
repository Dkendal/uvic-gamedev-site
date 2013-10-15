class Users::AuthController < ApplicationController
  skip_authorization_check
  def facebook
    request.env['omniauth.strategy'].options.scope = "email"
    render text: 'Omniauth setup phase.', status: 404
  end
end
