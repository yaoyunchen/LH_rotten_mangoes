Rails.application.routes.draw do

  get 'home/index'

  resource :session, only: [:new, :create, :destroy]

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  
  resources :users, only: [:new, :create, :show]
  
  namespace :admin do
    resources :users
  end 

  

  root to: 'home#index'
end
