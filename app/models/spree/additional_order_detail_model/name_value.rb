class Spree::AdditionalOrderDetailModel::NameValue < ActiveRecord::Base
  attr_accessible :name, :value
  belongs_to :order_detailable, polymorphic: true
end
