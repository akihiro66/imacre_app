Rails.application.routes.draw do
  root "static_pages#home"
  get :about, to: "static_pages#about"
  get :signup, to: "users#new"
  get :login, to: "sessions#new"
  post :login, to: "sessions#create"
  delete :logout, to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :productions
  resources :relationships, only: [:create, :destroy]
  post "favorites/:production_id/create" => "favorites#create"
  delete "favorites/:production_id/destroy" => "favorites#destroy"
end
