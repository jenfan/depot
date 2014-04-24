class RenameColumnIdPrototype < ActiveRecord::Migration
  def change
  	rename_column :prototype_properties, :id_properties, :property_id
  	rename_column :prototype_properties, :id_prototype, :prototype_id
  end
end
