Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }


  root to: 'pages#home'
  get '/learn', to: 'pages#learn'

  get '/profile', to: 'users#show'
  get '/macrocalculator', to: 'users#update'

  get '/profile/history', to: 'orders#index'

  resources :macros, path: '/profile/macros'

  get '/change_default_macros/:new_default', to: 'macros#change_default', as: 'change_default_macros'

  resources :orders, only: [:index, :show, :create, :new] do
    resources :payments, only: :new do
      collection do
        get :success
      end
    end
      resources :order_dishes, only: [:update, :create, :destroy]
    end

  resources :dishes, only: [:index,:show] do
    resources :reviews, only: [:create, :index]
  end

  resources :eateries, only: [:show]

  # resources :profiles, only: [:show, :create, :update] do
  #   resources :macros, only: [:new, :create, :update, :destroy]
  # end

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
