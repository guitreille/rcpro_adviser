Rails.application.routes.draw do
  root "quotes#new"
  resources :quotes
end
