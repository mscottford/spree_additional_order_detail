Spree::Core::Engine.routes.draw do

  get "additional_order_detail_tabs" => 'AdditionalOrderDetails#main', as: :additional_order_detail_tabs

  scope '/api' do
    resources :additional_order_details
  end


  resources :additional_order_details

  namespace :admin do
    resources :additional_order_detail_descriptors

    resources :orders do
      get :additional_order_detail, on: :member
    end
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

    resources :option_values do
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

# need something like
# match '*path', to: 'AdditionalOrderDetail#main'
# at the very end of our routes due to pushState (see very end of http://railscasts.com/episodes/325-backbone-on-rails-part-2)
