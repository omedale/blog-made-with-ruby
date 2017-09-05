Rails.application.routes.draw do
 
  root 'posts#index', as: 'home'

  get 'register' => 'users#new'
  get 'posts' => 'posts#posts'
  resources :users, except: [:new]

  get 'about' => 'pages#about', as: 'about'

  resources :posts, except: [:posts] do 
    resources :comments
  end
end