Spree::Core::Engine.routes.draw do
  get "additional_order_detail" => 'AdditionalOrderDetail#main'

#  scope :additional_order_details do
#    scope :api do
      resources :vehicle_details #/additional_order_details/api/vehicle_details
#    end
#  end


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

# need something like
# match '*path', to: 'AdditionalOrderDetail#main'
# at the very end of our routes due to pushState (see very end of http://railscasts.com/episodes/325-backbone-on-rails-part-2)
