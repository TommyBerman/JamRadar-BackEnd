Rails.application.routes.draw do
  resources :user_instruments
  resources :user_genres
  resources :users
  resources :instruments
  resources :genres
  resources :users , except: :create

  post "/sign-in", to: "users#sign_in"
  get "/validate", to: "users#validate"
  get "/items", to: "users#items"
  post "/sign-up", to: "users#create"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
