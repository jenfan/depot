namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Category.create!(
                 name: "Санки",
                 url_name: 'Sanki')
    6.times do |n|
      title  = Faker::Name.name
      url_name = ""
      Product.create!(name: name,
                   url_name: url_name,)
                   
    
  end
    Product.create!(title: "Example Product",
                 price: '5',
                 category_id: '1',
                 subcategory_id: '3')
    5.times do |n|
      title  = Faker::Name.name
      price = 1..500
      category_id = 1..7
      subcategory_id = 1..7
      Product.create!(title: title,
                   price: price,
                   category_id: category_id,
                   subcategory_id: subcategory_id)
    end
  end
end