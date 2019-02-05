Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :products do
      resources :product_files do
        collection do
          post :update_positions
        end
      end
    end
  end
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :products do
        resources :product_files
      end
    end
  end
end
