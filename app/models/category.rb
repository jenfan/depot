class Category < ActiveRecord::Base
	has_many :subcategories, dependent: :destroy
	has_many :products
	belongs_to :menu

	
end
