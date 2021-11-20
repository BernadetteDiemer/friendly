Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :bookings, only: :index

  get '/users/:user_id', to: 'users#show', as: 'profile'
  patch '/users/:user_id', to: 'users#update', as: 'update_profile'
  get '/users/:user_id/events', to: 'users#index', as: 'users_events'
  get '/users/:user_id/pastbookings', to: 'pages#pastbookings', as: 'pastbookings'

  resources :events do
    resources :bookings, only: [:new, :show, :create, :update, :destroy] do
      resources :reviews, only: [:new, :create, :edit, :update]
    end
  end
end
