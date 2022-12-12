Rails.application.routes.draw do
  root "quotes#new"
  get "quotes/index"

  resources :quotes
end
