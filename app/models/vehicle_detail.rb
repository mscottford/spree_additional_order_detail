class VehicleDetail < ActiveRecord::Base
  attr_accessible :make, :year

  validates :make, presence: true
  validates :year, presence: true, numericality: true
end
