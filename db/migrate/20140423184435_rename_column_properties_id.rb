class RenameColumnPropertiesId < ActiveRecord::Migration
  def change
 	rename_column :properties_values, :properties_id, :property_id
 	rename_table :properties_values, :property_values
  end
end
