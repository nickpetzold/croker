Rails.application.routes.draw do
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  get "dashboard", to: "dashboards#dashboard"
  resources :cryptocurrencies, only: [:index, :show] do
    resources :trades, only: [:new, :create]
    resources :charts, only: :show
    member do
     get 'chart/:timeframe', to: 'cryptocurrencies#chart', as: :chart
   end
  end

  resources :top_ups, only: [:show, :new, :create] do
    resources :payments, only: [:new, :create]
  end
end
