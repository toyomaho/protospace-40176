Rails.application.routes.draw do
  devise_for :users
  root "prototypes#index"
  resources :users
  resources :prototypes do
    resources :comments
  end
end
