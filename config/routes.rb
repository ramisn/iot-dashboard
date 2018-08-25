Rails.application.routes.draw do
  resources :import  do
    collection do
      post :import
    end
  end
  resources :iot_data do
    # get  'process_start' => 'iot_data#process_start'
    # match '/process_start' => 'iot_data#process_start', via: :post
    # match '/request' => 'iot_data#process_start', via: :get
    # member do
      get  :process_start
    # end
    collection do
      post :import
      # get  :process_start #/:id' => 'iot_data#process_start'
    end
  end
  
  resources :sensors
  devise_for :users, only: :session, path: 'session',
             path_names: { sign_in: 'login', sign_out: 'logout' }
  
  resources :users, only: [:show]

  # mount SensorsAdminPanel::V1 => '/'
  # mount GrapeSwaggerRails::Engine, at: "/documentation"

  # root to: 'visitors#index'
  root to: 'iot_data#index'
end
