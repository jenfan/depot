json.array!(@menus) do |menu|
  json.extract! menu, :id, :name, :permalink
  json.url menu_url(menu, format: :json)
end
