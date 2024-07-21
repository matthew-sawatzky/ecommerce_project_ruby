Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users
  root "pages#home"
  get 'pages/about'
    get 'about', to: 'pages#about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :cards, only: [:index, :show]
  resources :cardsets, only: [:index, :show]
  resources :card_sets, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # other routes

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
        get 'cardsetHandler', to: 'cards#cardset', as: :cardsethandler  


      resources :cards, only: [:index, :show, :search] do
    collection do
      get 'search'
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"

end
