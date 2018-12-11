Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "dashboards", to: "dashboards#dashboard", as: "dashboard"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trades, only: [:index, :show, :new, :create]
end
