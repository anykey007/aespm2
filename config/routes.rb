AESPM::Application.routes.draw do


  devise_for :users

  resources :index

  namespace :reporting_forms do
    resources :balance_lines, :plan_lines, :labor_lines, :finresult_lines, :b1_lines, :tanimotos
  end

  resources :reporting_forms

  resources :companies do
    get "/reportings/index"
#    resources :reportings
    namespace :reportings do
      resources :balances do
        collection do
          get 'download_pdf'

        end
      end
      resources :plans
      resources :labors
      resources :finresults
      resources :b1s
      resources :tanimotos do
        member do
          post '/show_compared' => 'tanimotos#show_compared', :as => "show_compared"
          get '/compare' => 'tanimotos#compare', :as => "compare"      
          get '/tanimotos_by_company' => 'tanimotos#tanimotos_by_company', :as => "tanimotos_by_company"      
        end
      end

    end
    match 'performance/index' => 'performance#index', :via => [:get, :post]
    match 'performance/charts' => 'performance#charts', :via => [:get, :post]
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
  root :to => 'companies#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end

