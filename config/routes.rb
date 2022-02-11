Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "users/registrations" }
  get "/" => redirect("/home")
  get "/home", to: "page#home"
  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:create, :destroy]
end
