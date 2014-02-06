namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Product.create!(title: "Example Product",
                 description: "Пластиковый корпус",
                 image_url: "example.jpg",
                 price: '5')
    50.times do |n|
      title  = Faker::Name.name
      description = "example-#{n+1}@railstutorial.org"
      image_url = "example.jpg"
      price = '5.5'
      Product.create!(title: title,
                   description: description,
                   image_url: image_url,
                   price: price)
    end
  end
end