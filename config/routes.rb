Rails.application.routes.draw do

  get 'home/index'

  resource :session, only: [:new, :create, :destroy]

  resources :movies do
    resources :reviews, only: [:new, :create]
  end  

  resources :users, only: [:new, :create, :show]
  
  namespace :admin do
    resources :users
    post '/users/:id', to: 'users#spy_mode', as: 'spy_mode'
    get '/revert', to: 'users#revert', as: 'revert_to_admin'

  end 

  

  root to: 'home#index'
end
