Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions'
  }

  resources :articles
  resources :films

  namespace :api do
    resources :articles, only: [:index, :show]
  end
end
