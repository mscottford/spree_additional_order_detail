class VehicleDetail < ActiveRecord::Base
  attr_accessible :make, :year

  validates :make, presence: true
  validates :year, presence: true, numericality: true

  has_one :additional_order_detail, as: :detailed

  def to_json(options={})
    super(options.merge(except: [:created_at, :updated_at]))
  end

end
