class CreateSpreeAdditionalOrderDetailModelNameValues < ActiveRecord::Migration
  def change
    create_table :spree_additional_order_detail_model_name_values do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
