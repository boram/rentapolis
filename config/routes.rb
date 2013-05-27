Rentapolis::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create', as: :omniauth_callback
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: :signout

  get 'signup', to: 'signup#new', as: :signup
  post 'signup', to: 'signup#create', as: :new_signup
  get 'signin', to: 'sessions#new', as: :signin
  post 'signin', to: 'sessions#create', as: :new_signin

  namespace :api do
    resources :rentals
  end

  root to: 'home#index'

  match '/*path' => 'home#index', via: [:get, :post]
end
