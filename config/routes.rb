Rails.application.routes.draw do
  root "home#index"
  get '/' => 'home#index', as: :home_page

  # Authentication
  get    "/signup", to: "users#new", as: :signup
  post   "/signup", to: "users#create"

  get    "/login",  to: "sessions#new", as: :login
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # User account 
  get    "/account", to: "users#show",    as: :account
  get    "/account/edit", to: "users#edit",    as: :edit_account
  patch  "/account", to: "users#update"
  delete "/account", to: "users#destroy"

  resources :categories
  resources :todos do
    collection do
      get :completed
    end
  end
end