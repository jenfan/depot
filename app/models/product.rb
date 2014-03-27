class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :subcategory
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	def self.category
	  Category.find(category_id)
	end

	# accepts_nested_attributes_for :subcategory
	# accepts_nested_attributes_for :subcategory, :allow_destroy => true, :reject_if => :all_blank
	# SUBCATEGORY_TYPES = Subcategory.all.to_a
	CATEGORY_TYPES = Category.all.map { |city| [city.name, city.id] }
	SUBCATEGORY_TYPES = Subcategory.all
	def c_subcategory
		Subategory.all
	end

	# scope :subcategory (where category)
	def self.search(page)
	  Product.paginate :per_page => 9, :page => page,
	           # :conditions => ['name like ?', "%#{search}%"],
	           :order => 'title'
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
