Rails.application.routes.draw do
  
  devise_for :realtors
  devise_for :users
  resources :proposals , only: [:index]
  root to: 'properties#index'
  get 'by_region', to: 'properties#search', as: 'search'
  get 'by_realtor', to: 'properties#realtor'
  resources :properties, only: [:show, :new, :create, :edit, :update] do
    resources :proposals, only: [:new, :create]
  end
  resources :proposals, only: [:show] do
    post '/approve', to: 'proposals#approve'
  end
  resources :property_types, only: [:show, :new, :create]
  resources :regions, only: [:show, :new, :create]

  
end
