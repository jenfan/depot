class Prototype < ActiveRecord::Base
	has_many :products
	has_many :prototype_properties
	has_many :properties, through: :prototype_properties
end
