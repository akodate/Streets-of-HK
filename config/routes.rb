StreetsOfHk::Application.routes.draw do

  root 'site#index'

  get 'search' => 'site#search'
  post 'search' => 'site#search'

  get 'display' => 'display#new'
  get 'error' => 'display#error', as: :error

  get 'register' => 'register#new'
  post 'register' => 'register#create'

  get 'login' => 'session#new'
  post 'login' => 'session#create'
  delete 'logout' => 'session#destroy'

  # get 'logout' => 'session#destroy' #TODO: remove before deployment

  get 'privacy' => 'site#privacy'
  get 'terms' => 'site#terms'

  get 'reset/:code' => 'password#edit', as: :reset
  put 'reset/:code' => 'password#update'
  patch 'reset/:code' => 'password#update'

  get 'register/:code' => 'register#confirm', as: :confirmation

end
