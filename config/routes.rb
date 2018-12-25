Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users do
    collection do
      post 'export'
    end
    member do
      post 'like'
      post 'dislike'
    end
  end
end
