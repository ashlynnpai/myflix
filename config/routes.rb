Myflix::Application.routes.draw do
 
  
  root to: 'pages#front'
  get '/home', to: 'videos#index'
    
  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  
  get 'ui(/:action)', controller: 'ui'
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  get 'my_queue', to: 'queue_items#index'
  
  resources :users, only: [:show, :create, :edit, :update]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]
  
  resources :categories, only: [:new, :create, :show]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'
  
  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'
 
end
