class VehicleDetail < ActiveRecord::Base
  attr_accessible :make, :year

  validates :make, presence: true
  validates :year, presence: true, numericality: true

  has_one :additional_order_detail, as: :detailed
end
