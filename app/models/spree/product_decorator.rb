module Spree
  Product.class_eval do
    include SpreeAdditionalOrderDetail::Describing
  end
end
