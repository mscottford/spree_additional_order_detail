class CreateVehicleDetails < ActiveRecord::Migration
  def change
    create_table :vehicle_details do |t|
      t.string :make
      t.integer :year

      t.timestamps
    end
  end
end
