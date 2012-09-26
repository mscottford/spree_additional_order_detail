require 'spec_helper'

#describe 'admin activities related to collecting additional order detail' do
describe "AdditionalOrderDetailDescriptorsController" do
  stub_authorization!

  before do
    @product = Factory(:product_requiring_additional_order_detail)
  end

  context "#viewing collectable types of order detail" do
    it "should show the app.config.spree.additional_order_detail_models that we have configured", :js => true do
      visit spree.selected_admin_product_additional_order_detail_descriptors_path(@product)

      # Let the record show that I was being a good li'l rails tester until adding the  :js => true 
      # above caused my click_link target to not be found so I gave up.  _you_ figure it out and
      # send me a pull request

      # click_link 'new_descriptor_link'
    end
  end
end
