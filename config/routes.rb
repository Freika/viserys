Rails.application.routes.draw do
  devise_for :users
  root 'main#index'
  resources :posts
  get '/month/:year/:month', to: 'posts#index', as: :month
  get '/week/:year/:week', to: 'posts#index', as: :week
  get '/months/:year', to: 'posts#months', as: :months
  get '/weeks/:year', to: 'posts#weeks', as: :weeks
end
