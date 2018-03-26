Rails.application.routes.draw do


  get 'dcrs/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :registrations => "registrations"}
  
  root 'home#index'
  ################# Workorders ######################
  get '/workorders' => 'workorder#index'
  post '/workorders/:erpno' => 'workorder#index'
  get '/addworkorder' => 'workorder#new'
  post 'create' => 'workorder#create'
  get '/workorder/:id/change' => 'workorder#change'
  patch 'workorder/:id/update' => 'workorder#update'
  ################# Stockworkorder ######################
  get '/stockworkorders' => 'physicalstock#index'
  get '/stockworkorders/:locno' => 'physicalstock#index'
  get '/addstockworkorder' => 'physicalstock#new'
  post '/physicalstock/create' => 'physicalstock#create'
  get '/stockworkorder/:id/change' => 'physicalstock#change'
  patch '/physicalstock/:id/update' => 'physicalstock#update'

  ################# Dcrs ######################
  get '/dcrs/:id' => 'dcrs#index'
  get '/dcr/today/change' => 'dcrs#today_change'
  patch 'dcrupdate' => 'dcrs#dcrupdate'

  ################# Dcrs ######################
  get '/daily_rec_cum_mails' => 'dailymail#dailyrec_cum'
  get '/dailyrecmail' => 'dailymail#dailyrec'
  get '/dailycummail' => 'dailymail#dailycum'









  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
