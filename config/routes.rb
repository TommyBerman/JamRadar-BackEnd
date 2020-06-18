Rails.application.routes.draw do
  resources :user_question_details, except: :show
  resources :user_instruments
  resources :user_genres
  resources :users, except: [:destroy, :create]
  resources :instruments
  resources :genres

  post "/sign-in", to: "users#sign_in"
  get "/validate", to: "users#validate"
  post "/sign-up", to: "users#create"
  get "/candidates", to: "users#candidates"
  put "/users", to:"users#update"
  delete "/users", to: "users#destroy"
  post "/like", to: "users#like"
  get "/matches", to: "users#matches"
  delete "/matches", to: "users#unmatch"
  
end
