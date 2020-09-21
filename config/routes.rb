Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'players#index'

  resources :players do
    post 'add' => 'watch#create'
    delete '/add' => 'watch#destroy'

    collection do
      get 'modal'
    end
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'dividend/index'

  post   '/sell',   to: 'transaction#sell'
  post   '/buy',   to: 'transaction#buy'

  resources :transaction do

  end

  resources :users do
    collection do
      get 'login'
      post 'signin'
    end
  end 
end
