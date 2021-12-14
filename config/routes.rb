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
  resources :posts, except: %i[show] do
    member do
      patch "upvote", to: "posts#upvote"
      get 'author_options', to: 'posts#author_options'
    end
  end
end
