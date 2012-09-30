class VehicleDetail < ActiveRecord::Base
  self.include_root_in_json = false

  attr_accessible :make, :year

  validates :make, presence: true
  validates :year, presence: true, numericality: true

  has_one :additional_order_detail, as: :detailed

  def to_json(options={})
    super(options.merge(except: [:created_at, :updated_at]))
  end

end
