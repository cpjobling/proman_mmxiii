PromanMmxiii::Application.routes.draw do

  get "static_pages/home"

  get "static_pages/help"

  ActiveAdmin.routes(self)

  root :to => "projects#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  resources :users, :only => :show

  resources :projects do
    get 'page/:page', :action => :index, :on => :collection
    collection do
      get 'by_discipline/:discipline', action: 'by_discipline'
    end
    collection do
      get 'allocated', action: 'allocated'
    end
    collection do
      get 'unavailable', action: 'unavailable'
    end
    collection do
      get 'tutors', action: 'tutors'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :disciplines
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
