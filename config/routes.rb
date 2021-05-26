Rails.application.routes.draw do
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
  
  resources :users
end
