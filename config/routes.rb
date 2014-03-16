StreetsOfHk::Application.routes.draw do

  root 'site#index'

  get 'privacy' => 'site#privacy'
  get 'terms' => 'site#terms'

  get 'register' => 'site#register'

  get 'login' => 'session#new'
  post 'login' => 'session#create'
  delete 'logout' => 'session#destroy'

  get 'logout' => 'session#destroy' #TODO: remove before deployment

end
