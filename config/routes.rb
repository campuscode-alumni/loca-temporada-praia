Rails.application.routes.draw do
  
  devise_for :realtors
  root to: 'properties#index'
  get 'by_region', to: 'properties#search',as: 'search'
  resources :properties, only: [:show, :new, :create, :edit, :update] do
    resources :proposals, only: [:show, :new, :create]
  end

  resources :property_types, only: [:show, :new, :create]
  resources :regions, only: [:show, :new, :create]
end
