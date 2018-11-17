Rails.application.routes.draw do

  resources :images
  root "home#index"
  get 'home/index'

  resources :albums
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
