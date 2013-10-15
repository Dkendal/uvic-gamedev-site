GameDev::Application.routes.draw do
  root to: 'home#index'

  resources :events
  namespace :admin do
    resources :users, except: :new
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "users/auth/facebook/setup", to: "users/auth#facebook"

  ComfortableMexicanSofa::Routing.admin(:path => '/admin/cms')
  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)
end
