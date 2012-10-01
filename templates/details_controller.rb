# ./app/controllers/spree/<%= model_class_name.pluralize.underscore %>_controller.rb
module Spree
  class <%= model_class_name.pluralize %>Controller < BaseController
    respond_to :json

    def index
      respond_with <%= model_class %>.all
    end

    def show
      respond_with <%= model_class %>.find(params[:id])
    end

    def create
      <%= model_class_name.underscore %> = <%= model_class %>.create(params[:<%= model_class_name.underscore %>])
      if <%= model_class_name.underscore %>.valid?  # why in the world is create() returning an object and not true false??
        line_item = Spree::LineItem.find(params[:line_item_id])

        additional_order_detail = line_item.additional_order_details.build
        additional_order_detail.detailed = <%= model_class_name.underscore %>
        additional_order_detail.line_item = line_item
      
        additional_order_detail.save!
      end

      respond_with <%= model_class_name.underscore %>
    end

    def update
      respond_with <%= model_class %>.update(params[:id], params[:<%= model_class_name.underscore %>])
    end

    def destroy
      respond_with <%= model_class %>.destroy(params[:id])
    end
  end
end
