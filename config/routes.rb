Rails.application.routes.draw do
  root to: 'main#index'
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      resources :open_library, only: [:index, :show], param: :isbn
    end
  end

  get 'paginate', to: 'dummy_models#index'
end
