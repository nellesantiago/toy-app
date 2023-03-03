Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  # root "users#index"
  root "home_page#index"
  
  get 'home_page/index'
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"

  resources :users, except: :new do
    resources :posts
  end

  get "feed", to: "feed#index"
end


