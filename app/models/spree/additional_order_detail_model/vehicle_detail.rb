class Spree::AdditionalOrderDetailModel::VehicleDetail < ActiveRecord::Base
  attr_accessible :make, :year

  has_many :additional_order_details, as: :detailed
end
