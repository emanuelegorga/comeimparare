Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    post 'auth/login', to: 'authentication#authenticate'

    resources :users, only: [:create, :index]
    resources :courses do
      resources :lectures, only: [:show, :create, :update, :destroy]
    end
  end
end
