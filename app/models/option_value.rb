class OptionValue < ActiveRecord::Base
	belongs_to :option_type

	has_many :product_option_values
	has_many :products, through: :product_option_values

	def quantity
		product_option_values.first.quantity || 0
	end

end
