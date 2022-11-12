Rails.application.routes.draw do
  # get "/endpoints", to: "endpoints#show"
  # post "/endpoints", to: "endpoints#create"
  # patch "/endpoints/:id", to: "endpoints#update"
  # delete "/endpoints/:id", to: "endpoints#destroy"
  resources :endpoints, only: [:index, :show, :create, :update, :destroy]
  match "*all", to: "endpoints#custom", via: :all
end
