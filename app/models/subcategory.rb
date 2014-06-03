class Subcategory < ActiveRecord::Base
	belongs_to :category
	belongs_to :menu
	has_many :products
end
