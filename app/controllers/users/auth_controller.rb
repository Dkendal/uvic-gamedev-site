class Users::AuthController < ApplicationController
  def facebook
    request.env['omniauth.strategy'].options.scope = "email"

    render text: 'Omniauth setup phase.', status: 404
  end
end
