class AddUrlNameToCategory < ActiveRecord::Migration
  def change
  	  	add_column :categories, :url_name, :string
	  	add_column :subcategories, :url_name, :string
  end
end
