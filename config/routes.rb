Rails.application.routes.draw do
  # namespace :api do
  #     namespace :v1 do
  #       resources :iot_data do
  #         get 'search', on: :collection
  #       end
  #       # root to: 'bot_details#index'
  #     end
  # end
  # resources :iot_data
  resources :iot_data do
          get 'search', on: :collection
        end
  resources :sensors
  devise_for :users, only: :session, path: 'session',
             path_names: { sign_in: 'login', sign_out: 'logout' }
  resources :users, only: [:show]

  mount SensorsAdminPanel::V1 => '/'
  mount GrapeSwaggerRails::Engine, at: "/documentation"

  root to: 'visitors#index'
end
