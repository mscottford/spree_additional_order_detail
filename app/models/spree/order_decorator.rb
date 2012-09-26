module Spree
  Order.class_eval do
    def requires_additional_detail?
      self.line_items.any? { |line_item| line_item.product.requires_additional_detail? }
    end
  end
end
