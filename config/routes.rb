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

  get 'blank', to: 'home#blank'
  root to: "home#index"
  end
