module Spree
  LineItem.class_eval do
    has_many :additional_order_details

    attr_accessible :additional_order_details_attributes

    accepts_nested_attributes_for :additional_order_details_attributes

    def additional_detail_steps
      self.variant.additional_detail_steps
    end
  end
end
