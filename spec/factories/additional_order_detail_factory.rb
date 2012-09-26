FactoryGirl.define do

  factory :additional_order_detail_descriptor, :class => Spree::AdditionalOrderDetailDescriptor do
    name 'My Descriptor'
    model_name 'Spree::AdditionalOrderDetailModel::NameValue'
  end

  factory :product_requiring_additional_order_detail, :parent => :product do
    after_create { |product| Factory(:additional_order_detail_descriptor, 
                                    :describable_type => 'Spree::Product', 
                                    :describable_id => product.id) 
    }
  end

  factory :option_type_requiring_additional_order_detail, :parent => :option_type do
    after_create { |option_type| Factory(:additional_order_detail_descriptor, 
                                        :describable_type => 'Spree::OptionType', 
                                        :describable_id => option_type.id) 
    }
  end

  factory :option_value_requiring_additional_order_detail, :parent => :option_value do
    after_create { |option_value| Factory(:additional_order_detail_descriptor, 
                                         :describable_type => 'Spree::OptionValue', 
                                         :describable_id => option_value.id) 
    }
  end

end
