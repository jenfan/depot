class CreateProductOptionValues < ActiveRecord::Migration
  def change
    create_table :product_option_values do |t|
      t.integer :product_id
      t.integer :option_value_id
      t.integer :quantity

      t.timestamps
    end
    add_index :product_option_values, :product_id
    add_index :product_option_values, :option_value_id
  end
end
