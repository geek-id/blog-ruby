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
  get '/users', to: 'users#index', as: '/users/'

  get '/users/add', to: 'users#new'
  post '/users',  to: 'users#create'
  delete '/users/:id', to: 'users#destroy', as: '/user'
  get '/users/:id/profile', to: 'users#show', as:'/user/profile'
  get '/users/:id/edit', to: 'users#edit', as: '/user/edit'
  patch '/users/:id', to: 'users#update'
  put '/users/:id', to: 'users#update'

  # resources :users

  get 'posts', to: 'posts#index',as: '/posts/'
  get 'posts/create', to: 'posts#new'
  post 'posts', to: 'posts#create'
  # post '/posts/:post_id/attach', to: 'posts#attach', as: '/posts/attach'
  delete 'posts/:id', to: 'posts#destroy', as: '/post'
  get 'posts/draft', to: 'posts#draft'
  # get 'posts/:id', to: 'posts#show'

  # resources :posts do
  #   post 'attach' => 'posts#attach'
  # end

  get 'posts/:id/edit', to: 'posts#edit', as: '/post/edit'
  patch 'posts/:id', to: 'posts#update'
  put 'posts/:id', to: 'posts#update'

  post 'attachment/upload', to: 'post_attachment#upload'
  get 'attachment/index', to: 'post_attachment#index'
  delete 'attachment/destroy', to: 'post_attachment#destroy'
  # get 'post_attachment', to: 'post_attachment#index'
  # delete 'post_attachment/:id', to: 'post_attachment#destroy'

  get 'tags/:tag', to: 'pages#tag', as: "tag"

  resources :subcriber, only: [:index, :create]

  # resources :post_attachment
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
