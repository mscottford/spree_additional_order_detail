class CreateSpreeAdditionalOrderDetails < ActiveRecord::Migration
  def change
    create_table :spree_additional_order_details do |t|
      t.integer :detailed_id
      t.string :detailed_type
      t.integer :line_item_id

      t.timestamps
    end
  end
end
