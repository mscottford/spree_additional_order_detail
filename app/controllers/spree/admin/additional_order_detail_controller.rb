module Spree
  module Admin
    class AdditionalOrderDetailController < ResourceController
      belongs_to 'spree/order', :find_by => :number

      def index
        
      end
    end
  end
end
