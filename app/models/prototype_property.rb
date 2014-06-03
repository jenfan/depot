class PrototypeProperty < ActiveRecord::Base
	belongs_to :prototype
	belongs_to :property
end
