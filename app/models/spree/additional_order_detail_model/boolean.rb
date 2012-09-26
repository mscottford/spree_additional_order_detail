class Spree::AdditionalOrderDetailModel::Boolean < ActiveRecord::Base
  attr_accessible :name1, :name2, :value

  has_many :additional_order_details, as: :detailed
end
