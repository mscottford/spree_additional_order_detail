module SpreeAdditionalOrderDetail
  module Describing
    extend ActiveSupport::Concern

    module ClassMethods
    end
 
    def requires_additional_detail?
      self.additional_order_detail_descriptors.present?
    end
    
    def requires_additional_detail_for?(step)
      self.additional_order_detail_descriptors.select {|d| d.step_name == step.to_s}.present?
    end

    included do |base|
      base.has_many :additional_order_detail_descriptors, as: :describable
    end
  end
end
