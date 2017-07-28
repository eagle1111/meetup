Rails.application.routes.draw do
  devise_for :users
  root 'meetups#index'
  resources :meetups do
    resources :comments
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :sessions, only: [:create]
      resources :meetups, only: [:index]
    end
  end
end
