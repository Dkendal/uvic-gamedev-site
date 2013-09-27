class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to :back, alert: exception.message
    else
      redirect_to new_user_session_path
    end
  end
end
