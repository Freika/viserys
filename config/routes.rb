Rails.application.routes.draw do
  devise_for :users
  root 'main#index'
  resources :posts
  get '/months/:year/:month', to: 'posts#index'
  get '/weeks/:year/:week', to: 'posts#index'
end
