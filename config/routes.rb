# config/routes.rb
Rails.application.routes.draw do
  get 'static_pages/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  root "pages#home"
  get 'pages/about'
  get 'about', to: 'pages#about'
  post 'cards/add_to_cart/:id', to: 'cards#add_to_cart', as: 'add_to_cart'
  delete 'cards/remove_from_cart/:id', to: 'cards#remove_from_cart', as: 'remove_from_cart'
resources :static_pages, only: [:show]

  resources :cards, only: [:index, :show, :search] do
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
