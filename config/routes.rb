Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :bookings, only: [:index, :update, :show, :destroy]

  get '/users/:user_id', to: 'users#show', as: 'profile'
  patch '/users/:user_id', to: 'users#update', as: 'update_profile'
  get '/users/:user_id/events', to: 'users#index', as: 'users_events'

  resources :events do
    resources :bookings, only: [:new, :create]
  end
end
