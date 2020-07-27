Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root                'static_pages#home'

  get    'home'    => 'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'

  resources :users

  get    'signup'  => 'users#new'
  get    'signin'  => 'sessions#new'

  post   'signin'  => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :account_activations, only: [:edit]
  resources :stories
  resources :chapters
  resources :comments,            only: [:create]

end
