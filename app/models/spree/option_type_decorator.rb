module Spree
  OptionType.class_eval do
    include SpreeAdditionalOrderDetail::Describing
  end
end
