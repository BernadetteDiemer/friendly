Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bookings, only: :index

  get '/users/:user_id', to: 'users#show', as: 'profile'

  resources :events do
    resources :bookings, only: [:new, :create, :update, :destroy]
  end
end
