Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  root "pages#home"
  get 'pages/about'
  get 'about', to: 'pages#about'

  resources :cards, only: [:index, :show, :search] do
    collection do
      get 'search'
    end
  end

  resources :card_sets, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      post 'populate'
      post 'select', to: 'card_sets#select'
    end
  end

  resource :cart, only: [:show] do
    post 'add', on: :collection
    post 'checkout', on: :collection
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
