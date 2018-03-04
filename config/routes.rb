Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { :registrations => "registrations"}
  
  root 'home#index'
  
  get '/workorders' => 'workorder#index'
  post '/workorders/:erpno' => 'workorder#index'
  get '/addworkorder' => 'workorder#new'
  post 'create' => 'workorder#create'
  get '/workorder/:id/change' => 'workorder#change'
  patch 'workorder/:id/update' => 'workorder#update'










  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
