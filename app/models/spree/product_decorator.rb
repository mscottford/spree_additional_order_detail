module Spree
  Product.class_eval do
    include SpreeAdditionalOrderDetail::Describing

    def additional_detail_steps
      # product-level 
      steps_from_product = self.additional_order_detail_descriptors.map { |desc| desc.describable }.flatten

      # option-type-level 
      # steps_from_option_type = self.option_types.map { |ot| ot.additional_order_detail_descriptors.map { |desc| desc.describable }.flatten

      # option-value-level 
      # 
    end

  end
end
