Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
  root 'users#index'
  resources :products
  resources :users do
    collection do
      post 'export'
      get 'hot'
    end
    member do
      post 'like'
      post 'dislike'
      get :following, :followers
      put 'online'
      put 'left'
    end
  end

  namespace :admin do
    resources :users
  end

  resources :relationships, only: [:create, :destroy]
end
