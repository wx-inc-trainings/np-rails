Rails.application.routes.draw do
  root to: 'main#index'
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
  namespace :api do
    namespace :v1 do
      resources :open_library, only: [:index, :show], param: :isbn
      resources :book, only: %i[index show]
      resources :book_suggestion, only: %i[create index]
      resources :rent, only: %i[create index]
    end
  end
end
