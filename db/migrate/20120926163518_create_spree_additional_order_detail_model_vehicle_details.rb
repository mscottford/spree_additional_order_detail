class CreateSpreeAdditionalOrderDetailModelVehicleDetails < ActiveRecord::Migration
  def change
    create_table :spree_additional_order_detail_model_vehicle_details do |t|
      t.string :make
      t.integer :year

      t.timestamps
    end
  end
end
