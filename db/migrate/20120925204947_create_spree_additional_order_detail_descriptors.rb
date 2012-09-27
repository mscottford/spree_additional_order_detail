class CreateSpreeAdditionalOrderDetailDescriptors < ActiveRecord::Migration
  def change
    create_table :spree_additional_order_detail_descriptors do |t|
      t.string :step_name
      t.string :model_name
      t.integer :position
      t.string :describable_type
      t.integer :describable_id

      t.timestamps
    end
  end
end
