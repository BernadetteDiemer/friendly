Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bookings, only: :index
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  resources :events do
    resources :bookings, only: [:new, :create, :update, :destroy]
  end
end
