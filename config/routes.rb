Rails.application.routes.draw do
  resources :wallets
  resources :users do
    member do
      get :dashboard
    end
  end
  resources :sessions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#new"
end
