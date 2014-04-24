class RenameColumnPropVal < ActiveRecord::Migration
  def change
  	rename_column :properties_values, :prototype_id, :product_id
  end
end
