CkPrzelewy24::Engine.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :p24_transactions, only: [] do
      collection do
        post :confirm
      end
    end
  end
end
