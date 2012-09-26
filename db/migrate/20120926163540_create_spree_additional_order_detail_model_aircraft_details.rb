class CreateSpreeAdditionalOrderDetailModelAircraftDetails < ActiveRecord::Migration
  def change
    create_table :spree_additional_order_detail_model_aircraft_details do |t|
      t.string :aircraft_type
      t.integer :year

      t.timestamps
    end
  end
end
