class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity+=1
		else
        	current_item = line_items.build(product_id: product_id)
        end
        current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end

	def total_quantity
		line_items.to_a.sum { |item| item.quantity }
	end

	def remove_item(id)
		current_item = line_items.find_by_id(id)
		if current_item.quantity > 1
			current_item.quantity-=1
			current_item.save
		else
			current_item.quantity=0
        	current_item.destroy
        end
        current_item || id
	end
end
