Spree::Core::Engine.routes.draw do
  resources :aircraft_details

  get "additional_order_detail" => 'AdditionalOrderDetail#main', as: :additional_order_details

  scope '/api' do
    resources :additional_order_details
  end


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
