Rails.application.routes.draw do

  root 'main#index'
  resources :posts
  devise_for :users
end
