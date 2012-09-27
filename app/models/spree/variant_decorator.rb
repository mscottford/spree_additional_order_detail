module Spree
  Variant.class_eval do
    include SpreeAdditionalOrderDetail::Describing

    def additional_detail_steps
      # product-level 
      steps_from_product = self.product.additional_order_detail_descriptors.map { |desc| desc.model_name }.flatten

      # option-type-level 
      steps_from_option_types = 
        # get all option types for this variant
        self.option_values.map { |ov| ov.option_type }.uniq.
        # get all descriptors assigned to each option type
                           map { |ot| ot.additional_order_detail_descriptors }.flatten.
        # get the specific model for each descriptor
                           map { |desc| desc.model_name }.uniq

      # option-value-level 
      steps_from_option_values = 
        # get all descriptors assigned to each option value

        self.option_values.map { |ov| ov.additional_order_detail_descriptors }.
        # get the specific model for each descriptor
                           map { |desc| desc.model_name }.uniq

      (steps_from_product + steps_from_option_types + steps_from_option_values).uniq.map(&:to_s).map {|s| s.split("::").last }.map(&:underscore).map(&:to_sym)
    end

  end
end
