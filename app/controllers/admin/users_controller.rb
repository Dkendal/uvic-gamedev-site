class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource class: 'User'

  def index
    @users = User.includes :roles
  end
end
