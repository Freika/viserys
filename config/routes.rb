Rails.application.routes.draw do
  devise_for :users
  root 'main#index'
  resources :posts
  get '/months/:year/:month', to: 'posts#month'
end
