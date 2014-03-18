class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.decimal :articul
      t.string :title
      t.string :proizvoditel
      t.decimal :price, precision: 8, scale: 2
      t.decimal :price_discount, precision: 8, scale: 2
      t.decimal :price_second, precision: 8, scale: 2
      t.decimal :price_second_discount, precision: 8, scale: 2
      t.decimal :kol_v_upakovke, precision: 8
      t.string :category
      t.string :subcategory
      t.string :category
      t.decimal :discount
      t.boolean :hit
      t.boolean :is_show
      t.decimal :vsego
      t.decimal :reserv
      t.decimal :svobod_ostatok
      t.boolean :is_new
      
      
      t.text :description
      t.string :image_url
      

      t.timestamps
    end
  end
end
