class AddCategoryIdToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :category_id, :integer
  	add_column :products, :subcategory_id, :integer
  end
end
