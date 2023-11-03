Rails.application.routes.draw do
  devise_for :owners
  root 'home#index'
  resources :login , only: [:index]
end
