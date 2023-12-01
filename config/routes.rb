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
    get 'avaliations', on: :member
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
    resources :avaliations, only: [:new, :create]
  end
  resources :avaliations, only: [:index] do
    resources :answers, only: [:new,:create]
  end
  resources :check_ins, only: :index
  get 'meus-quartos', to: 'rooms#my_rooms', as: 'my_rooms'
  get 'minhas-reservas', to: 'reservations#my_reservations', as: 'my_reservations'


  namespace :api do
    namespace :v1 do
      resources :inns, only: [:index, :show] do
        post 'search', on: :collection
        resources :rooms, only: [:index]
      end
      resources :reservations, only: [:create]
      post 'availability', to: 'reservations#availability'
    end
  end
end
