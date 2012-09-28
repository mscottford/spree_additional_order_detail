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
      respond_with VehicleDetail.create(params[:vehicle_detail])
    end

    def update
      respond_with VehicleDetail.update(params[:id], params[:vehicle_detail])
    end

    def destroy
      respond_with VehicleDetail.destroy(params[:id])
    end
  end
end
