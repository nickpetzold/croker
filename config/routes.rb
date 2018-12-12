Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "dashboard", to: "dashboards#dashboard"
  resources :cryptocurrencies, only: [:index, :show] do
    resources :trades, only: [:new, :create]
  end
end
