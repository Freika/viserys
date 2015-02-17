Rails.application.routes.draw do
  devise_for :users
  root 'main#index'
  resources :posts
  get '/months/:year/:month', to: 'posts#month'
  get '/weeks/:year/:week', to: 'posts#week'
end
