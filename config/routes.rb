Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "users/registrations" }
  root "page#index"

  resources :users, only: [:show, :edit, :update]
end
