Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "users/registrations" }
  get "/" => redirect("/feed")
  get "/feed", to: "page#feed"
  get "/about", to: "page#about"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:create, :destroy, :edit, :update]
  resources :comments, only: [:create, :destroy, :edit, :update]
  resources :follows, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  #errors
  match "*unmatched", to: "application#route_not_found", via: :all
end
