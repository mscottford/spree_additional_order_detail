module Spree
  Product.class_eval do
    include SpreeAdditionalOrderDetail::Describing

    def additional_detail_steps
      self.additional_order_detail_descriptors.map { |desc| desc.step_name }.flatten
    end

  end
end
