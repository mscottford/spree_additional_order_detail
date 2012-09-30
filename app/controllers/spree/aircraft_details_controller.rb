module Spree
  class AircraftDetailsController < BaseController
    respond_to :json

    def index
      respond_with AircraftDetail.all
    end

    def show
      respond_with AircraftDetail.find(params[:id])
    end

    def create
      line_item_id = params[:line_item_id]

      aircraft_detail = AircraftDetail.create(params[:aircraft_detail])

      line_item = Spree::LineItem.find(line_item_id)

      additional_order_detail = line_item.additional_order_details.build
      additional_order_detail.detailed = aircraft_detail
      additional_order_detail.line_item = line_item
      
      additional_order_detail.save!

      respond_with aircraft_detail
    end

    def update
      respond_with AircraftDetail.update(params[:id], params[:aircraft_detail])
    end

    def destroy
      respond_with AircraftDetail.destroy(params[:id])
    end
  end
end
