class Spree::AdditionalOrderDetailModel::NameValue < ActiveRecord::Base
  attr_accessible :name, :value

  has_many :additional_order_details, as: :detailed
end
