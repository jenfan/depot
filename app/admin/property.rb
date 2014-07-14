ActiveAdmin.register PrototypeProperty do
  belongs_to :property
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

ActiveAdmin.register Property do

  index do
      column "ID", :id
      column "Название", :name
      actions 
    end  

    sidebar "Project Details", only: [:show, :edit] do
     ul do
      li link_to "Property",    admin_property_prototype_properties_path(property)
    end
  end

end

