Rails.application.routes.draw do

  root "orders#index"

  resources :orders, only: [:create, :index]
  resource :order_confirmation, only: [:show]

  mount CkPrzelewy24::Engine => "/ck_przelewy24", as: "ck_przelewy24"
end
