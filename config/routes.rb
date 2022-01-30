Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    post 'auth/login', to: 'authentication#authenticate'

    resources :users, only: [:create, :index]

    resources :joins do
      get :my_students, on: :collection
    end

    resources :courses do
      get :purchased, 
        :pending_review,
        :created,
        :pending,
        :rejected,
        :from_different_teachers, 
        on: :collection

      member do
        patch :accept
        patch :reject
        patch :publish
        patch :unpublish
      end

      resources :lectures do
        member do
          delete :delete_video
        end
        
        resources :remarks
      end

      resources :joins do
        member do
          get :certificate
        end
      end
    end

    get 'privacy_policy', to: 'home#privacy_policy'
  end
end
