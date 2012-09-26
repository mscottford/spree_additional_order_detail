module Spree
  Order.class_eval do
    def additional_detail_steps
      self.line_items.map { |li| li.additional_detail_steps }.flatten.uniq.map(&:to_sym)
    end

    def requires_additional_detail?
      self.line_items.any? { |line_item| line_item.product.requires_additional_detail? }
    end
  end
end
