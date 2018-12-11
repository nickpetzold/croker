Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
    resources :trade, only: [:index, :show, :new, :create]

end
