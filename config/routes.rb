Rails.application.routes.draw do
  get 'checkout/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  root "pages#home"
  
  get 'pages/about', as: 'about'
  resources :static_pages, only: [:show], param: :title
  get 'checkout', to: 'checkout#index', as: 'checkout'
  resources :cards, only: [:index, :show] do
    member do
      post 'add_to_cart'
      delete 'remove_from_cart'
      patch 'update_cart_item'
    end
    collection do
      get 'search'
    end
  end

  resources :card_sets, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      post 'select'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
