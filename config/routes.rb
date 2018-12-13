Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "dashboard", to: "dashboards#dashboard"

  resources :cryptocurrencies, only: [:index, :show] do
    get "call_chart", to: "cryptocurrencies#call_chart"
    resources :trades, only: [:new, :create]
    resources :charts, only: :show
  end

  resources :top_ups, only: [:show, :new, :create] do
    resources :payments, only: [:new, :create]
  end
end
