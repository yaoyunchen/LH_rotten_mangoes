Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  
  resources :users, only: [:new, :create, :show]
  
  namespace :admin do
    resources :users
  end 


  root to: 'movies#index'
end
