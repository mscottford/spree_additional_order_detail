require 'spec_helper'

describe 'viewing the cart page' do
  context '#no additional info required' do

    before do
      @product = Factory(:product)
      visit '/products'
      click_link @product.name
      click_button "Add To Cart"
    end

    it 'should show the add-to-cart button' do
      page.should have_link('Checkout')
    end
  end

  context '#additional info required' do
    include_context 'cart_that_requires_additional_order_detail'

    context '#already present' do

      context '#fully' do
        it 'should show the add-to-cart button' do
          page.should have_link('Checkout')
        end
      end

      context '#partially' do
        it 'should show the additional-info-required button' do
          page.should_not have_link('Checkout')
          page.should have_link('Proceed to Provide Additional Info')
        end
      end
    end

    context '#not present' do
      it 'should show the additional-info-required button' do
        page.should_not have_link('Checkout')
        page.should have_link('Proceed to Provide Additional Info')
      end
    end
  end
end
