module CmsAuth
  def authenticate
    authenticate_user!
    authorize_resource
  end
end
