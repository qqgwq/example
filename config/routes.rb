Rails.application.routes.draw do
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
    end
  end

  namespace :admin do
    resources :users
  end
end
