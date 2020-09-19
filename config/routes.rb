Rails.application.routes.draw do
  get 'dividend/index'
  resources :players
  root to: 'players#index'
  resources :users do
    collection do
      get 'login'
      post 'signin'
    end
  end 
end
