Rails.application.routes.draw do
  get 'dividend/index'
  resources :players
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root to: 'players#index'
  resources :users do
    collection do
      get 'login'
      post 'signin'
    end
  end 
end
