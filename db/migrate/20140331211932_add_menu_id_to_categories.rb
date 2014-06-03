class AddMenuIdToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :menu_id, :integer, unique: true
  	add_column :subcategories, :menu_id, :integer, unique: true
  	
  end
end
