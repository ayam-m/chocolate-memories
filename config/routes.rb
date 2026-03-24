Rails.application.routes.draw do
  # Devise
  devise_for :users
  # Defines the root path route ("/")
  root "home#index"
end
