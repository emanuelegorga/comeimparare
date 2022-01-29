Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    post 'auth/login', to: 'authentication#authenticate'

    resources :users, only: [:create, :index]
    resources :joins do
      get :my_students, on: :collection
    end

    resources :courses do
      get :purchased, :pending_review, :creatd, on: :collection
      resources :lectures, only: [:show, :create, :update, :destroy]
      resources :joins, only: [:create]
      get :from_different_teachers, on: :collection
    end
  end
end
