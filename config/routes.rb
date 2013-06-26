PicShare::Application.routes.draw do

  resources :requests

  get "users/policy"

  get "users/help"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :albums
  resources :album_sessions, only: [:new, :create, :destroy]
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout',  to: 'sessions#destroy', via: :delete
  match '/album_signup',  to: 'albums#new'
  match '/album_signin',  to: 'album_sessions#new'
  match '/album_signout', to: 'album_sessions#destroy', via: :delete
  match '/help', to: 'users#help'
  match '/policy', to: 'users#policy'

#  get "photos/index"

#  get "photos/create"
#  resources :photos,:only => [:index, :create, :destroy]
  resources :photos,:only => [ :destroy]
  root :to => 'users#index'

  resources :albums do
    member do
      put 'add_photos', :as => :add_photos
      post 'add_photos', :as => :add_photos
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
