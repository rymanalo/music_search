MusicSearch::Application.routes.draw do
  devise_for :users

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  root :to => 'searches#index'
  match "search", to: "searches#search"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


end
