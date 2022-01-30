Rails.application.routes.draw do
  devise_for :users
  root "page#index"

  resources :users, only: [:show, :edit, :update]
end
