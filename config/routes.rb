Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :groups, only: %i[index show] do
    resources :events
    resources :user_groups, only: %i[create destroy]
  end

  resources :events do
  resources :adventures, only: %i[index show create update]
  resources :notifications, only: %i[new create]
end


  resources :notifications

  resources :adventures, only: %i[show] do
    resources :votes, only: %i[create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
