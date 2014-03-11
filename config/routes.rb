StreetsOfHk::Application.routes.draw do

  root 'site#index'
  get 'privacy' => 'site#privacy'
  get 'terms' => 'site#terms'
  get 'login' => 'site#login'
  get 'register' => 'site#register'

end
