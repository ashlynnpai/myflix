Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'pages#front'
  get '/home', to: 'videos#index'
    
  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  get 'my_queue', to: 'queue_items#index'
  
  resources :users, only: [:show, :create, :edit, :update]
  
  resources :categories, only: [:new, :create, :show]
 
end
