shared_context "cart_that_requires_additional_order_detail" do

  before do
    @product = Factory(:product_requiring_additional_order_detail)
    visit '/products'
    click_link @product.name
    click_button "Add To Cart"
  end

  def shared_method
    "it works"
  end
end
