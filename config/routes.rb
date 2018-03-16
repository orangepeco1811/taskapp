Rails.application.routes.draw do
  
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'toppages/index'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'


  
  get 'signup', to: 'users#new'
  resources :users

  resources :tasks do
    member do
      get "kanryo"
      get "mikan"
    end
  end
end