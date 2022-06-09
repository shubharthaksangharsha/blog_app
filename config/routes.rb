Rails.application.routes.draw do
  root "articles#index"

  get 'articles/get_archived_posts', to: "articles#get_archived_posts"

  resources :articles do
    get :change_to_public, member: true
    resources :comments
  end



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
