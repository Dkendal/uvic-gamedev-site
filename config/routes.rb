GameDev::Application.routes.draw do
  resources :events

  namespace :admin do
    resources :users, except: :new
  end

  get '/auth/facebook/setup', to: 'facebook#setup'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  ComfortableMexicanSofa::Routing.admin(:path => '/admin/cms')
  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)
end
