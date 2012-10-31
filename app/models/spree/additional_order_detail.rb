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

  # Company Name would be an instance of  
  # Spree::AdditionalOrderDetailModel::CompanyName
  
  # Member Names and Addresses would be an instance of  
  # Spree::AdditionalOrderDetailModel::MemberNamesAndAddresses

  def as_json(options={})
    super( options.merge( { except: [:created_at, 
                                   :updated_at], 
                            methods: :detailed_contents
                          }
                        ))
  end

  def detailed_contents
    self.detailed.as_json
  end
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
end
