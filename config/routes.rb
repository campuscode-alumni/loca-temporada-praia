Rails.application.routes.draw do
  root to: 'properties#index'
  get 'by_region', to: 'properties#search',as: 'search'
  resources :properties, only: [:show, :new, :create]
  resources :property_types, only: [:show, :new, :create]
  resources :regions, only: [:show, :new, :create]
end
