Rails.application.routes.draw do
  root "static_pages#home"
  get :about, to: "static_pages#about"
  get :signup, to: "users#new"
  resources :users
  get :login, to: "sessions#new"
  post :login, to: "sessions#create"
  delete :logout, to: "sessions#destroy"
end
