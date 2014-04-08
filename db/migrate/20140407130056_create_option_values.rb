class CreateOptionValues < ActiveRecord::Migration
  def change
    create_table :option_values do |t|
      t.string :name
      t.string :title
      t.integer :option_type_id

      t.timestamps
    end
    add_index :option_values, :option_type_id
  end
end
