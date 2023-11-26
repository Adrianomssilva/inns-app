Rails.application.routes.draw do
  devise_for :users
  devise_for :owners
  root 'home#index'
  resources :login , only: [:index]
  get 'minha-pousada' , to: 'inns#my_inn', as: 'my_inn'
  resources :inns , only: [:new, :create, :edit, :update, :show,] do
    get 'search', on: :collection
    patch 'publish', on: :member
    patch 'hidden', on: :member
  end
  resources :rooms, only: [:new, :create, :edit, :update, :show] do
    patch 'unavailable', on: :member
    patch 'available', on: :member
    resources :prices, only: [:new, :create]
    resources :reservations, only: [:new, :create] do
      get 'confirmation', on: :new
    end
    post 'reservation_create', to: 'reservations#reservation_create'
  end
  resources :reservations, only: [:index, :show]  do
    patch 'cancel', on: :member
    patch 'owner_cancel', on: :member
    resources :check_ins, only: [:create]
    resources :check_outs, only: [:new, :create]
    resources :assessments, only: [:new, :create]
  end
  resources :check_ins, only: :index

  get 'meus-quartos', to: 'rooms#my_rooms', as: 'my_rooms'
  get 'minhas-reservas', to: 'reservations#my_reservations', as: 'my_reservations'
end
