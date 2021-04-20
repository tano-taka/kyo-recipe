Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  post "likes/:recipe_id/create", to: "likes#create"
  delete "likes/:recipe_id/destroy", to: "likes#destroy"
  resources :recipes do
    collection do
      get 'search'
    end
    member do
      get 'user'
    end
  end
end
