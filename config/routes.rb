Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#authenticate'

      resources :users, only: [:create]
      resources :courses
    end
  end
end
