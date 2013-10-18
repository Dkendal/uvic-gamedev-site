class Admin::TokensController < Admin::BaseController
  load_and_authorize_resource class: 'Token'

  def index
    @tokens = Token.all
  end

  def show
  end

  def create
    session[:token_creation_state] = :callback_started
    session[:fb_permissions] = 'create_event manage_pages email'
    redirect_to user_omniauth_authorize_path :facebook
  end

  def update
    if @token.update(token_params)
      redirect_to [:admin, @token], notice: 'Token was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @token.destroy
    redirect_to admin_tokens_url, notice: 'Token was successfully destroyed.'
  end

  private
    def token_params
      params.require(:token).permit(:user_id, :token)
    end
end
