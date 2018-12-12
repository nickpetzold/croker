Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "dashboard", to: "dashboards#dashboard"
  resources :trades, only: [:index, :show, :new, :create]

  resources :top_ups, only: [:show, :new, :create] do
    resources :payments, only: [:new, :create]
  end
end
