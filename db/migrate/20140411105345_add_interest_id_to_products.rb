class AddInterestIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :interest_id, :integer
    add_column :interests, :name, :string
    add_index :products, :interest_id
  end
end
