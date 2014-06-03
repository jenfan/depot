class CreatePrototypeProperties < ActiveRecord::Migration
  def change
    create_table :prototype_properties do |t|
      t.integer :id_properties
      t.integer :id_prototype

      t.timestamps
    end
  end
end
