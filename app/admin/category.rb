ActiveAdmin.register Category do

  menu label: "Категории", priority: 2

  index do
    column "Название", :name #do |name|
      # name=I18n.transliterate(name.name)
      # end
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
  
end
