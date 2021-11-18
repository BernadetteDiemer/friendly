Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :bookings, only: :index

  get '/users/:user_id', to: 'users#show', as: 'profile'
  patch '/users/:user_id', to: 'users#update', as: 'update_profile'

  resources :events do
    resources :bookings, only: [:new, :show, :create, :update, :destroy]
  end
end
