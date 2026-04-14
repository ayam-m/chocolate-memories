Rails.application.routes.draw do
  # Devise
  devise_for :users
  # Defines the root path route ("/")
  root "records#index"
  resources :records, only: %i[index new create show edit update destroy]
end
