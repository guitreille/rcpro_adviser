Rails.application.routes.draw do
  root "simulations#new"
  resources :simulations
end
