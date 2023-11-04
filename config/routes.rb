Rails.application.routes.draw do
  devise_for :owners
  root 'home#index'
  resources :login , only: [:index]
  get 'minha-pousada' , to: 'inns#my_inn', as: 'my_inn'
  resources :inns , only: [:new, :create, :edit, :update] do
    patch 'publish', on: :member
    patch 'hidden', on: :member
  end
end
