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
end
