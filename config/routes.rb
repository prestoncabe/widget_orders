Rails.application.routes.draw do
  resources :orders, only: [:new,:create]
  root to: 'orders#new'
end
