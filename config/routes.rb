Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { :registrations => "registrations"}
  
  root 'home#index'
  
  get '/workorders' => 'workorder#index'
  post '/workorders/:search' => 'workorder#index'

  get '/addworkorder' => 'workorder#new'
  post 'create' => 'workorder#create'










  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
