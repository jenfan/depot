class Property < ActiveRecord::Base
	# должно быть Property а не  Properies
	has_many :property_values
	has_many :prototype_properties
	has_many :prototype, through: :prototype_properties
end
