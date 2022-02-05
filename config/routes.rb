Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    post 'auth/login', to: 'authentication#authenticate'

    resources :users, only: [:create, :index, :show, :update, :destroy]

    resources :joins do
      get :my_students, on: :collection

      member do
        get :certificate
      end
    end

    resources :orders do
      get :full_list, on: :collection
    end

    # post :create_payment_intent, to: 'orders#create_payment_intent'

    resources :courses do
      get :purchased, 
        :pending_review,
        :created,
        :pending,
        :rejected,
        :from_different_teachers,
        :top,
        on: :collection

      member do
        patch :accept
        patch :reject
        patch :publish
        patch :unpublish
        put :upload
        put :rate_course
      end

      resources :lectures do
        member do
          delete :delete_video
        end
        
        resources :remarks
      end

      resources :joins, only: %i[create]
    end

    get 'privacy_policy', to: 'home#privacy_policy'
  end
end
