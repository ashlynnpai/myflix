Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'pages#front'
  get '/home', to: 'videos#index'
  
#   get '/videos/search', to: 'videos#search'

#   get '/videos/:id', to: 'videos#show', as: "video" do
#     post '/reviews', to: 'reviews#create'
#   end
  
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
  
  resources :users, only: [:show, :create, :edit, :update]
  
  resources :categories, only: [:new, :create, :show]
 
end
