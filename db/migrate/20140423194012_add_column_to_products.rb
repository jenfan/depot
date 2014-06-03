class AddColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :prototype_id, :integer
  end
end
