module Spree
  Variant.class_eval do
    include SpreeAdditionalOrderDetail::Describing

    def additional_detail_steps
      # product-level 
      steps_from_product = self.product.additional_order_detail_descriptors.map { |desc| desc.describable }.flatten

      # option-type-level 
      steps_from_option_types = 
        # get all option types for this variant
        self.option_values.map { |ov| ov.option_type }.uniq.
        # get all descriptors assigned to each option type
                           map { |ot| ot.additional_order_detail_descriptors }.flatten.
        # get the specific model for each descriptor
                           map { |desc| desc.describable }.uniq

      # option-value-level 
      steps_from_option_values = 
        # get all descriptors assigned to each option value

        self.option_values.map { |ov| ov.additional_order_detail_descriptors }.
        # get the specific model for each descriptor
                           map { |desc| desc.describable }.uniq


      (steps_from_product + steps_from_option_types + steps_from_option_values).uniq
    end

  end
end
