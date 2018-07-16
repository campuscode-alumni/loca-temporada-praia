Rails.application.routes.draw do

  devise_for :realtors
  devise_for :users
  resources :proposals , only: [:index]
  root to: 'properties#index'
  get 'by_region', to: 'properties#search',as: 'search'
  resources :properties, only: [:show, :new, :create, :edit, :update] do
  resources :proposals, only: [:show, :new, :create]
  end


  get 'property_type/all_property_types', to: 'property_types#all_property_types'
  get 'region/all_regions', to: 'regions#all_regions'
  get 'property/all_properties', to: 'properties#all_properties'

  resources :property_types, only: [:show, :new, :create,:edit,:update]
  resources :regions, only: [:show, :new, :create,:edit,:update]
end
