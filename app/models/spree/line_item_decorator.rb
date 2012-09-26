module Spree
  LineItem.class_eval do
    has_one :vehicle_detail
  end
end
