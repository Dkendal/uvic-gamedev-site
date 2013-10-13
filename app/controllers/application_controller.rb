class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  check_authorization unless: :skip_authentication?

  def skip_authentication?
    controller_path.match( /cms_admin/ ) ||
      devise_controller?
  end

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to :back, alert: exception.message
    else
      redirect_to new_user_session_path
    end
  end
end
