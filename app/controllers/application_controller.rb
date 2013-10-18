class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception, unless: :skip_protect_from_forgery?
  check_authorization unless: :skip_authentication?

  def skip_authentication?
    controller_path.match( /cms_admin/ ) ||
      devise_controller?
  end

  def skip_protect_from_forgery?
    false
  end

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      begin
        redirect_to :back, alert: exception.message
      rescue ActionController::RedirectBackError
        redirect_to :root
      end
    else
      redirect_to new_user_session_path
    end
  end
end
