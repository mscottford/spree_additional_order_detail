class Spree::AdditionalOrderDetail < ActiveRecord::Base
  attr_accessible :detailed, :detailed_id, :detailed_type, :line_item_id, :detailed_attributes

  @@detailed_types = []

  def self.detailed_types=(val)
    @@detailed_types = val
  end
  # this could represent things like
  # 1) a simple 'Company Name'
  # 2) a collection of member names and addresses

  belongs_to :detailed, polymorphic: true
  
  accepts_nested_attributes_for :detailed

  belongs_to :line_item

  validate :check_detailed_valid_in_context

  def mandatory?
    # TODO: make this a db field
    true
  end

  # http://railsforum.com/viewtopic.php?id=44575
  # http://stackoverflow.com/questions/3969025/accepts-nested-attributes-for-with-belongs-to-polymorphic
#  def build_detailed(params)
#    raise "Unknown detail_type: #{detail_type}" unless @@detail_types.include?(detail_type)
#    self.detailed = detailed_type.constantize.new(params)
#  end


  def attributes=(attributes = {})
    self.detailed_type = attributes[:detailed_type]
    super
  end

  def detailed_attributes=(attributes)
    some_detailed = self.detailed_type.constantize.find_or_initialize_by_id(self.detailed_id)
    some_detailed.attributes = attributes
    self.detailed = some_detailed
  end

  # hack in case one additional order detail's detailed object needs to know other things about the line item
  def check_detailed_valid_in_context
    if detailed.respond_to? :errors_in_context?
      err_str = detailed.errors_in_context?(self)
      self.errors[:base] << err_str if err_str.present?
    end
  end
end
