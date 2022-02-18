Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "users/registrations" }
  get "/" => redirect("/feed")
  get "/feed", to: "page#feed"
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts, only: [:create, :destroy, :edit, :update]
  resources :follows, only: [:create, :destroy]
end
