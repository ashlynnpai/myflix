Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'videos#index'
  
  get '/videos/search', to: 'videos#search'
  get '/home', to: 'videos#index'
  get '/videos/:id', to: 'videos#show', as: "video"
  
  resources :categories, only: [:new, :create, :show]
 
end
