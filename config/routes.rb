Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join('|')}/ do
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
      end
    end
  end
end
