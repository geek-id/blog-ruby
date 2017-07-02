Rails.application.routes.draw do
  # Session Login
  get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  # Get Front Page
  root 'pages#home'
  # get 'pages/home'
  get 'about-me', to: "pages#about"
  get 'content/:id', to: 'pages#show', as: 'content'

  #Dashboard Panel
  get '/dashboard', to: 'dashboard#new'
  delete '/logout', to: 'sessions#destroy'

  # Get user manage
  get 'dashboard/users', to: 'users#index', as: 'users'

  get 'dashboard/users/add', to: 'users#new', as: 'users/add'
  post 'dashboard/users',  to: 'users#create'
  delete 'dashboard/users/:id', to: 'users#destroy', as: '/user'
  get 'dashboard/users/:id/profile', to: 'users#show', as:'/user/profile'
  get 'dashboard/users/:id/edit', to: 'users#edit', as: '/user/edit'
  patch 'dashboard/users/:id', to: 'users#update'
  put 'dashboard/users/:id', to: 'users#update'

  # resources :users

  get 'dashboard/posts', to: 'posts#index',as: '/posts/'
  get 'dashboard/posts/create', to: 'posts#new', as: 'posts/create'
  post 'dashboard/posts', to: 'posts#create'
  # post '/posts/:post_id/attach', to: 'posts#attach', as: '/posts/attach'
  delete 'dashboard/posts/:id', to: 'posts#destroy', as: '/post'
  get 'dashboard/posts/draft', to: 'posts#draft', as: 'posts/draft'
  # get 'posts/:id', to: 'posts#show'

  # resources :posts do
  #   post 'attach' => 'posts#attach'
  # end

  get 'dashboard/posts/:id/edit', to: 'posts#edit', as: '/post/edit'
  patch 'dashboard/posts/:id', to: 'posts#update'
  put 'dashboard/posts/:id', to: 'posts#update'

  post 'attachment/upload', to: 'post_attachment#upload'
  get 'attachment/index', to: 'post_attachment#index'
  delete 'attachment/destroy', to: 'post_attachment#destroy'
  # get 'post_attachment', to: 'post_attachment#index'
  # delete 'post_attachment/:id', to: 'post_attachment#destroy'

  get 'tags/:tag', to: 'pages#tag', as: "tag"

  resources :subcriber, only: [:index, :create]

  get '*path', controller: 'application', action: 'render_404', as: "four_oh_four"


  # resources :post_attachment
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
