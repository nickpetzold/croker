Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "dashboard", to: "dashboards#dashboard"
  resources :trades, only: [:index, :show, :new, :create]
end
