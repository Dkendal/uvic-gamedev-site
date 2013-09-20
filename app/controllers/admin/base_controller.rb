class Admin::BaseController < ApplicationController
  def current_ability
    @current_ability ||= Admin::Ability.new(current_user)
  end
end
