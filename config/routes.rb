Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    post 'auth/login', to: 'authentication#authenticate'

    resources :users, only: [:create]
    resources :courses
  end
end
