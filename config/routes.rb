Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'players#index'

  resources :players, only: [:index, :show] do
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

  resources :users, only: [:index, :create, :show, :new]

  get '*path', controller: 'application', action: 'render_404'
end
