Spree::Core::Engine.routes.draw do
  resources :additional_order_detail_steps

  namespace :admin do
    resources :products do
      resources :additional_order_detail_descriptors do
        member do
          post :select
          get :remove
        end

        collection do
          get :available
          get :selected
        end

        get :select

      end
    end
  end
end
