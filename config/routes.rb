Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :cryptocurrencies, only: [:index, :show]
    resources :trades, only: [:index, :show, :new, :create]
end
