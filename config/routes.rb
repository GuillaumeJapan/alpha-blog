Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'pages#home' 
  get 'about', to: 'pages#about' 
  
  resources :articles
  
  get 'signup', to: 'users#new' 
  post 'users', to: 'users#create' # Create the missing route
  #resources :users, except: [:new] # Create all the routes except the tailored one for the 'new' action
   
end
