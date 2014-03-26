AdvisorFeed::Application.routes.draw do
  devise_for :admins, :controllers => { :sessions => "admin/sessions", :invitations => 'admin/invitations'} do
    get 'admins/login' => 'admin/sessions#new', :as => "new_admin_session"
    get 'admins/logout' => 'admin/sessions#destroy', :as => "destroy_admin_session"
    get 'admins/sign-up' => 'admin/sessions#new', :as => "new_admin_session"
  end

  devise_for :users

  #admin settingss
  namespace :admin do
    get '/users' => "users#index", :as => "users"
    root :to =>  "users#index"
    resources :users do
      get '/download_report' => "users#download_report", :as => "download_report"
      get '/destroy_report' => "users#destroy_report", :as => "destroy_report"
      get '/view_reports' => "users#view_reports", :as => "view_reports"
      resource :attachments
    end
  end

  root :to => redirect("/users/sign_in")
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'admin/reports#index'

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
    # namespace :admin do
    #   # Directs /admin/products/* to Admin::ProductsController
    #   # (app/controllers/admin/products_controller.rb)
    #   resources :reports
    # end


  namespace :users do
    get '/download_report' => 'dashboards#download_report'
    get '/dashboard' => 'dashboards#index'
  end

end
