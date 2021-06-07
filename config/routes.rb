Rails.application.routes.draw do
  #get 'password_resets/new'
  #get 'password_resets/edit'
  #root
  root 'static_pages#home'
   
  #gets  
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  
  #posts
  post '/login', to: 'sessions#create'
  
  #deletes
  delete '/logout', to: 'sessions#destroy'
  
  #resources
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
