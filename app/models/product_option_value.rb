class ProductOptionValue < ActiveRecord::Base
	belongs_to :product
	belongs_to :option_value
	
end
