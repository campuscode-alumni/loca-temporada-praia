Rails.application.routes.draw do
  root to: 'properties#new'
  resources :properties, only: [:show, :new, :create, :edit, :update] do
    resources :proposals, only: [:show, :new, :create]
  end
  resources :property_types, only: [:show, :new, :create]
  resources :regions, only: [:show, :new, :create]
end
