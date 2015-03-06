Rails.application.routes.draw do

  devise_for :users
  root 'main#index'

  resources :posts do
    resources :comments, except: :index
  end
  resources :news do
    resources :comments, except: :index
  end

  get 'graph', to: 'posts#graph'

  get '/month/:year/:month', to: 'posts#index', as: :month
  get '/week/:year/:week', to: 'posts#index', as: :week
  get '/years/:year', to: 'posts#years', as: :years
  get '/months/:year', to: 'posts#months', as: :months
  get '/weeks/:year', to: 'posts#weeks', as: :weeks
  get '/public', to: 'main#public_posts', as: :public_posts
end
