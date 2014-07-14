Demo::Application.routes.draw do

devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  

  root to: 'products#index', as: 'root'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/bonus', to: 'static_pages#bonus', as: 'bonus'
  get '/contact', to: 'static_pages#contact', as: 'contact'
  get '/help', to: 'static_pages#help', as: 'help'
  get '/vopros', to: 'static_pages#vopros', as: 'vopros'


  resources :orders, :carts, :users
  resources :sessions , only: [:new, :create, :destroy]
  get "/products/:id", to: 'products#show', as: 'product'
  resources :products
    resources :line_items do
      member do
        get 'remove_item'
      end
    end
  

match '/signout', to: 'sessions#destroy', via: 'delete'
  get '/signin', to: 'sessions#new'
  get '/signup', to: 'users#new'
  get "store/index"

  
  get "/:menu/:category", to: 'products#index_category', as: 'category'
  get "/:menu/:category/:subcategory", to: 'products#index_subcategory', as: 'subcategory'
  get "/:menu", to: 'products#index_menu', as: 'menu'
  
  resources :menus



end
