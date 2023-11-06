Rails.application.routes.draw do
  devise_for :owners
  root 'home#index'
  resources :login , only: [:index]
  get 'minha-pousada' , to: 'inns#my_inn', as: 'my_inn'
  resources :inns , only: [:new, :create, :edit, :update, :show] do
    patch 'publish', on: :member
    patch 'hidden', on: :member
  end
  resources :rooms, only: [:new, :create, :edit, :update] do
    patch 'unavailable', on: :member
    patch 'available', on: :member
  end
  get 'meus-quartos', to: 'rooms#my_rooms', as: 'my_rooms'
end
