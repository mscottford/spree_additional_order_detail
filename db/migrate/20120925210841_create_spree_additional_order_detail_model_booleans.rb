class CreateSpreeAdditionalOrderDetailModelBooleans < ActiveRecord::Migration
  def change
    create_table :spree_additional_order_detail_model_booleans do |t|
      t.string :name1
      t.string :name2
      t.string :value

      t.timestamps
    end
  end
end
