class AircraftDetail < ActiveRecord::Base
  attr_accessible :aircraft_type, :year

  validates :aircraft_type, presence: true
  validates :year, presence: true, numericality: true

  has_one :additional_order_detail, as: :detailed

  def to_json(options={})
    super(options.merge(except: [:created_at, :updated_at]))
  end
end
