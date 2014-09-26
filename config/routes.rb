Tm2::Application.routes.draw do

  resources :companies

  resources :actions

  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  post "setdate" => "aorders#setdate", :as => "setdate"
  post "filldrivers" => "onlinedrivers#filldrivers", :as => "filldrivers"
  match "setonduty" => "onlinedrivers#setonduty", :as => "setonduty"
  match "setosort" => "aorders#setosort", :as => "setosort"
  match "aorders/:id/cancel" =>"aorders#ocancel", :as => "aorder_cancel"
  match "uporderstable" => "aorders#uporderstable", :as =>"uporderstable"
  match "tabel" => "actions#tabel", :as =>"tabel"
  post "password_reset" => "users#password_reset", :as => "password_reset"

  match "stat" => "stat#index", :as =>"stat"
  match "setstatdates" => "stat#setstatdates", :as =>"setstatdates"


#  get "onlinedrivers/:action/:id" => "onlinedrivers#index", :as=>"onlinedrivers"

  resources :users
  resources :sessions
  resources :onlinedrivers

  resources :adrivers
  resources :aorders

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match '/set_day_status' => 'aorders#set_day_status', :as=>'set_day_status'



  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  
  #root :to => "aorders#index"
  root :to => "sessions#new"


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
end
