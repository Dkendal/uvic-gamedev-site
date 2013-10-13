module CmsAuth
  def authenticate
    authenticate_user!
    # authorize! @_action_name, self
  end
end
