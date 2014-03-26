StreetsOfHk::Application.routes.draw do

  root 'site#index'

  get 'register' => 'site#register'

  get 'login' => 'session#new'
  post 'login' => 'session#create'
  delete 'logout' => 'session#destroy'

  # get 'logout' => 'session#destroy' #TODO: remove before deployment

  get 'privacy' => 'site#privacy'
  get 'terms' => 'site#terms'

  get 'reset/:code' => 'password#edit', as: :reset
  put 'reset/:code' => 'password#update'
  patch 'reset/:code' => 'password#update'

end
