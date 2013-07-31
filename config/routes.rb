GameDev::Application.routes.draw do
  get '/auth/facebook/setup', to: 'facebook#setup'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  ComfortableMexicanSofa::Routing.admin(:path => '/admin/cms')
  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)
end
