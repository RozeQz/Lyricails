Rails.application.routes.draw do
  root 'posts#index'
  get 'session/login'
  post 'session/create'
  get 'session/logout'
  resources :users do
    member do
      get "collection"
    end
  end
  resources :posts do
    member do
      patch "upvote", to: "posts#upvote"
    end
  end
  # get 'post/like/:post_id' => 'likes#save_like', as: :like_post
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
