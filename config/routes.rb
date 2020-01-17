Tm2::Application.routes.draw do

  resources :callists


  resources :calls


  resources :departments

  resources :companies

  resources :actions

  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  post "setdate" => "aorders#setdate", :as => "setdate"
  post "fillautos" => "onlineautos#fillautos", :as => "fillautos"
  match "setonduty" => "onlineautos#setonduty", :as => "setonduty", via: [:get, :post]
  match "setosort" => "aorders#setosort", :as => "setosort", via: [:get, :post]
  match "aorders/:id/cancel" =>"aorders#ocancel", :as => "aorder_cancel", via: [:get, :post]
  match "uporderstable" => "aorders#uporderstable", :as =>"uporderstable", via: [:get, :post]
  match "tabel" => "actions#tabel", :as =>"tabel", via: [:get, :post]
  # post "password_reset" => "users#password_reset", :as => "password_reset"
  match "aorders/:id/edit_odometer" =>"aorders#edit_odometer", :as => "edit_aorder_odometer", via: [:get, :post]

  match "stat" => "stat#index", :as =>"stat", via: [:get, :post]
  match "stat_xml" => "stat#index_xml", :as =>"stat_xml", via: [:get, :post]
  match "routelist" => "stat#routelist", :as =>"routelist", via: [:get, :post]


#  get "onlineautos/:action/:id" => "onlineautos#index", :as=>"onlineautos"

  resources :users
  resources :sessions
  resources :onlineautos

  resources :aautos
  resources :aorders

  match '/set_day_status' => 'aorders#set_day_status', :as=>'set_day_status', via: [:get, :post]


  root :to => "sessions#new"
 
end
