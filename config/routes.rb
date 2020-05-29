Rails.application.routes.draw do
  root 'rooms#index'
  resources :rooms do
    resources :messages, only: [:index]
  end
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
