module Spree
  OptionValue.class_eval do
    include SpreeAdditionalOrderDetail::Describing
  end
end
