Rails.application.routes.draw do
  devise_for :users
  root 'main#index'
  resources :posts
  get '/month/:year/:month', to: 'posts#index'
  get '/week/:year/:week', to: 'posts#index'
  get '/months/:year', to: 'posts#months', as: :months
end
