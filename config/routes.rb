Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/learn', to: 'pages#learn'

  get '/profile', to: 'users#show'
  get '/macrocalculator', to: 'users#update'

  resources :macros, path: '/profiles/macros'

  resources :orders, only: [:index, :show, :create, :new] do
    collection do
      get :success
    end
    resources :order_dishes, only: [:update, :create, :destroy]
  end

  resources :dishes, only: [:index,:show] do 
    resources :reviews, only: [:create, :index]
  end

  resources :eateries, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
