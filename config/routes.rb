Rails.application.routes.draw do
  root "home#index"

  get 'articles/get_archived_posts', to: "articles#get_archived_posts"
  get 'home/about'
  get 'home/index'

  resources :articles do
    get :change_to_public, member: true
    resources :comments
  end



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
