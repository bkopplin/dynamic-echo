Rails.application.routes.draw do
  resources :endpoints, only: [:index, :show, :create, :update, :destroy]
  match "*all", to: "endpoints#custom", via: :all
end
