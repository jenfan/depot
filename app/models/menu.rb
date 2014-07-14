class Menu < ActiveRecord::Base
	has_many :categories
	has_many :subcategories, through: :categories
	has_many :products, through: :subcategories
end
