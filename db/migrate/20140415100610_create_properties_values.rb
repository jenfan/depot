class CreatePropertiesValues < ActiveRecord::Migration
  def change
    create_table :properties_values do |t|
      t.integer :properties_id
      t.integer :prototype_id
      t.string :value

      t.timestamps
    end
  end
end
