Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users
    resources :breeds
    resources :listings
    
    root to: "users#index"
  end
  
  devise_for :users
  
  resources :listings
  
  namespace :seller do
    resources :registrations
  end

  namespace :buyer do
    resources :messages
  end
  root to: "home#landing"
 get '/home', to: 'home#index', as: 'home' 
  get '/show/:id', to: 'home#show', as:'list'
  get "/membership/new", to: "membership#new", as: "new_membership"
  get "/membership", to: "membership#index", as: "membership"
  get "/membership/complete", to: "membership#complete", as: "complete_membership"
  post "/membership/webhook", to: "membership#webhook"
end