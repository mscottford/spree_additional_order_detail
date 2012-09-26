module SpreeAdditionalOrderDetail
  module Describing
    extend ActiveSupport::Concern

    module ClassMethods
    end
 
    module InstanceMethods
      def requires_additional_detail?
        self.additional_order_detail_descriptors.present?
      end
    end 

    included do |base|
      base.has_many :additional_order_detail_descriptors, :as => :describable
    end
  end
end
