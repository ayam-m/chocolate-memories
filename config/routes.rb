Rails.application.routes.draw do
  # Devise
  devise_for :users
  # Defines the root path route ("/")
  # ログイン前トップ
  unauthenticated do
    root "home#index"
  end

  # ログイン後トップ
  authenticated :user do
    root "records#index", as: :authenticated_root
  end

  resources :records, only: %i[index new create show edit update destroy]
end
