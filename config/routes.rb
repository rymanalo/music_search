MusicSearch::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  match "users/omniauth_callbacks", to: 'searches#index'


  root :to => 'searches#index'
  match "search", to: "searches#search"
  match "sorry", to: "searches#sorry"



end
