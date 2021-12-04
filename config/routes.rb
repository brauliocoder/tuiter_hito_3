Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "tweets#index"
  devise_for :users
  
  post '/:id/follow', to: "friends#follow", as: "follow"
  post '/:id/unfollow', to: "friends#unfollow", as: "unfollow"
  
  resources :tweets, except: [:edit, :update] do
    resources :likes, only: [:create, :destroy]
  end

end
