Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :groups, only: %i[index show] do
    resources :events
  end

  resources :events do
    resources :adventures, only: %i[create]
    resources :notifications, only: %i[new create]
  end

  resources :notifications, only: %i[index show update]

  resources :adventures, only: %i[show] do
    resources :votes, only: %i[create]
  end

  # TODO: This route is currently disabled. Uncomment and configure if calendar functionality is needed in the future.
  # resources :calendars

  resources :groups, only: %i[index show] do
    resources :user_groups, only: %i[create destroy]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
