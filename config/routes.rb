Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'
  resources :users, except: [:index, :destroy]
  resources :posts, except: [:index, :new, :show]
  resources :backups, only: [:index, :create] do
    post 'download'
  end
  resources :donations, only: [:show]
  post 'donate' => 'donations#donate'
  resources :orders
  scope 'store' do
    post 'add_item' => 'cart#add_item'
    post 'hook'     => 'orders#hook'
    post 'hook_donate' => 'donations#hook_donate'
    get 'check_out' => 'cart#check_out'
    get 'view_cart' => 'cart#index'
    resources :store_items, :path => 'items', :as => 'items'
  end

  namespace :admin do
    get '/' => 'admin#index'
    resources :store_items
    resources :orders
  end

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  post    'search'  => 'application#search'

  get "*path" => redirect("/")

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
