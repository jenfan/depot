class Category < ActiveRecord::Base
	has_many :subcategories, dependent: :destroy
	has_one :product
end
