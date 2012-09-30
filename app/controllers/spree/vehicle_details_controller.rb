module Spree
  class VehicleDetailsController < BaseController
    respond_to :json

    def index
      respond_with VehicleDetail.all
    end

    def show
      respond_with VehicleDetail.find(params[:id])
    end

    def create
      vehicle_detail = VehicleDetail.create(params[:vehicle_detail])
      if vehicle_detail.valid?  # why in the world is create() returning an object and not true false??
        line_item = Spree::LineItem.find(params[:line_item_id])

        additional_order_detail = line_item.additional_order_details.build
        additional_order_detail.detailed = vehicle_detail
        additional_order_detail.line_item = line_item
      
        additional_order_detail.save!
      end

      respond_with vehicle_detail
    end

    def update
      respond_with VehicleDetail.update(params[:id], params[:vehicle_detail])
    end

    def destroy
      respond_with VehicleDetail.destroy(params[:id])
    end
  end
end
