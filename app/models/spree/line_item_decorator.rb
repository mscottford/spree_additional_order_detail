module Spree
  LineItem.class_eval do
    has_many :additional_order_details

    attr_accessible :additional_order_details_attributes

    accepts_nested_attributes_for :additional_order_details

    def additional_detail_steps
      variant.additional_detail_steps
    end

    def requires_additional_detail?
      product.requires_additional_detail? || 
        variant.option_values.any? { |ov| ov.requires_additional_detail? } || 
        variant.option_values.map(&:option_type).uniq.any? { |ot| ot.requires_additional_detail? }
    end

    def incomplete_additional_detail?
      requires_additional_detail? &&
        # not 100% on this one below
        (additional_order_details.size != additional_detail_steps.size)
    end

    # has 1 or some number up to and including 100% 
    def has_additional_detail?
      additional_order_details.present?
    end

    def additional_detail_for(step)
      return nil if step == :finish || !requires_additional_detail_for?(step)
      
      self.additional_order_details.detect { |aod| 
         # map the model name of the detailed class to the step.
         # if we are in this 'loop', and we map the step, then we will not 'need' additional 
         # detail (we already have it!)
         AdditionalOrderDetailDescriptor.find_by_model_name(aod.detailed.class.to_s).step_name == step.to_s
       }
    end

    def needs_additional_detail_for?(step)
      return false if step == :finish
      
      # we require details but don't yet have a matching one
      requires_additional_detail_for?(step) && additional_detail_for(step).blank?
    end

    def requires_additional_detail_for?(step)
      product.requires_additional_detail_for?(step) || 
        variant.option_values.any? { |ov| ov.requires_additional_detail_for?(step) } || 
        variant.option_values.map(&:option_type).uniq.any? { |ot| ot.requires_additional_detail_for?(step) }
    end

  end
end
