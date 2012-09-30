class Spree::AdditionalOrderDetail < ActiveRecord::Base
  attr_accessible :detailed, :detailed_id, :detailed_type, :line_item_id, :detailed_attributes

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

  def mandatory?
    # TODO: make this a db field
    true
  end
end
