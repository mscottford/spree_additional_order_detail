class CreateAircraftDetails < ActiveRecord::Migration
  def change
    create_table :aircraft_details do |t|
      t.integer :year
      t.string :aircraft_type
      t.timestamps
    end
  end
end
