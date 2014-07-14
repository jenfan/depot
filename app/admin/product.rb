ActiveAdmin.register Product do

  menu label: "Продукты", priority: 1
  # :label - The string or proc label to display in the menu. If it's a proc, it will be called each time the menu is rendered.
  # :parent - The string id (or label) of the parent used for this menu
  # :if - A block or a symbol of a method to call to decide if the menu item should be displayed
  # :priority - The integer value of the priority, which defaults to 10

  index do
    column "Артикул", :articul
    column "Название", :title
    column "Категория", :category
    column "Подкатегория", :subcategory
    column "Картинка", :image_url
    column "Описание", :description
    column "Цена", :price
    actions 
  end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
      permit_params :category_id, :subcategory_id, :interest_id, :prototype_id,:articul, :title, :proizvoditel, 
        :price, :price_discount, :price_second, :price_second_discount, :kol_v_upakovke,
        :discount, :hit,:is_show,:vsego,:reserv,:svobod_ostatok,:is_new,:description,:image_url,:id


end
