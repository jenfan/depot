class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :subcategory
	belongs_to :interest
	belongs_to :prototype

	has_many :line_items
	has_many :properties, through: :prototype
	has_many :product_option_values
	has_many :property_values
	has_many :option_values, through: :product_option_values
	before_destroy :ensure_not_referenced_by_any_line_item

	
	
	# scope :subcategory (where category)
	def self.search(page,number=9,order='title')
	  paginate :per_page => number, :page => page,
	           # :conditions => ['name like ?', "%#{search}%"],
	           :order => order
	end

	
	def add_product_option(product_id,value_id)
		current_product = Product.find(product_id)
		option = current_product.product_option_values.where(product_id:product_id, option_value_id: value_id)

		if option
			option.quantity+=1
		else
			option.build
        end
        option
	end

	#validates :title, :description, :image_url, presence: true
    #validates :price, numericality: {greater_than_or_equal_to: 0.01}
    #validates :title, uniqueness: true
    #validates :image_url, allow_blank: true, format: {
	 #   with: %r{\.(gif|jpg|png)\z}i,
	  #  message: 'must be a URL for GIF, JPG or PNG image.'
	    # URL должен указывать на изображение формата GIF, JPG или PNG
	#}

	
	#...
	private
	# убеждаемся в отсутствии товарных позиций, ссылающихся на данный товар
	def ensure_not_referenced_by_any_line_item
	    if line_items.empty?
	        return true
	    else
	        errors.add(:base, 'существуют товарные позиции')
	        return false
	    end
	end
end
