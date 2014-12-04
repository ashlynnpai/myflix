Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'pages#front'
  
  get '/videos/search', to: 'videos#search'
  get '/home', to: 'videos#index'
  get '/videos/:id', to: 'videos#show', as: "video"
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  
  resources :users, only: [:show, :create, :edit, :update]
  
  resources :categories, only: [:new, :create, :show]
 
end
