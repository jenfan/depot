Demo::Application.routes.draw do
  resources :menus

  resources :orders

  root to: 'products#index', as: 'store' # ...

  resources :carts
  
  resources :users
  resources :sessions , only: [:new, :create, :destroy]

  get 'admin', to: 'admin#index'
  match 'admin/products', to: 'admin#products', via: 'get'
  match 'admin/category', to: 'admin#category', via: 'get'
  match 'admin/category', to: 'admin#category_update', via: 'PATCH'
  match 'admin/subcategory', to: 'admin#subcategory', via: 'get'
  match 'admin/subcategory', to: 'admin#subcategory_update', via: 'PATCH'

  match '/signout', to: 'sessions#destroy', via: 'delete'
  get '/signin', to: 'sessions#new'
  get '/signup', to: 'users#new'
  get "store/index"

  get "/:menu/:category", to: 'products#index', as: 'category'
  get "/:menu/:category/:subcategory", to: 'products#index', as: 'subcategory'
  get "/products/:id", to: 'products#show', as: 'product'
resources :products
  resources :line_items do
    member do
      get 'remove_item'
    end
  end
  

  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
