class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  rescue_from Errno::ENOENT, with: :failed_to_connect_to_facebook
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if session[:token_creation_state] == :callback_started
      create_page_token
      session[:token_creation_state] = nil
      redirect_to [:admin, :tokens], notice: t('./token/success')
    else
      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end

  def create_page_token
      user_token = request.env["omniauth.auth"].credentials.token
      page_token = FbGraph::Page.new('uvicgamedev').fetch(
        access_token: user_token,
        fields: :access_token
      ).access_token
      @user.token.destroy
      @token = @user.build_token token: page_token
      @token.save
  end

  def failed_to_connect_to_facebook
    redirect_to :root, notice: t('.connection-failure')
  end
end
