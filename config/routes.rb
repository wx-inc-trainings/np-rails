# require 'devise_token_auth'

Rails.application.routes.draw do

  root to: 'main#index'
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :open_library, only: :show
    end
  end

  # namespace :api do
  #   namespace :vi do
  #   end
  # end

  # get '/api/service/get-book-isbn', to: 'open_library#book'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
