class Spree::AdditionalOrderDetailModel::AircraftDetail < ActiveRecord::Base
  attr_accessible :aircraft_type, :year

  has_many :additional_order_details, as: :detailed
end
