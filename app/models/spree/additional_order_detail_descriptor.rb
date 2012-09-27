class Spree::AdditionalOrderDetailDescriptor < ActiveRecord::Base
  attr_accessible :describable_id, :describable_type, :model_name, :step_name, :position

  belongs_to :describable, polymorphic: true
end
