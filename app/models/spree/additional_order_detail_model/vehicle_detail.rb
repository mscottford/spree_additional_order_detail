class Spree::AdditionalOrderDetailModel::VehicleDetail < ActiveRecord::Base
  attr_accessible :make, :year

  validates :make, presence: true
  validates :year, presence: true, numericality: true

  has_many :additional_order_details, as: :detailed
end
