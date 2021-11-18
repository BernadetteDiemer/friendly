Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/users/:user_id/events', to: 'users#index', as: 'users_events'

  resources :bookings, only: :index
  resources :events do
    resources :bookings, only: [:new, :show, :create, :update, :destroy]
  end
end
