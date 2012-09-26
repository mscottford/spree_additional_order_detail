class Spree::AdditionalOrderDetail < ActiveRecord::Base
  attr_accessible :detailed_id, :detailed_type, :line_item_id

  # this could represent things like
  # 1) a simple 'Company Name'
  # 2) a collection of member names and addresses

  belongs_to :detailed, polymorphic: true

  # Company Name would be an instance of  
  # Spree::AdditionalOrderDetailModel::NameValue
  
  # Member Names and Addresses would be an instance of  
  # Spree::AdditionalOrderDetailModel::MemberNamesAndAddresses
end
