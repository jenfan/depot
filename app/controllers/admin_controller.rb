class AdminController < ApplicationController
	layout 'admin/index'
  # skip_before_filter :verify_authenticity_token, :only => [:index, :show, :category, :category_update]
	# before_action :authenticate, only:

  def index
  end

  def products
  	@products = Product.includes(:category).includes(:subcategory).includes(:option_values).search(params[:page],9,'id')
    @categories = Category.all.map { |n| [n.name, n.id] }
    @subcategories = Subcategory.all
    logger.info(params[:product])
  	# @products = Product.all.search(params[:page])
  end

  def add_product_option
    # option = add_product_option(Product_id, value_id)
  end

  def add_product_option_value
    
  end

  def category
  	@category = Category.all
    @menu = Menu.all.map { |m| [m.name, m.id] }
  end

  def option_type
    @option_types = OptionType.all
  end

  def option_type_update
    @option_type = OptionType.find(option_type_params[:id])
    respond_to do |format|
      if @option_type.update(option_type_params)
        flash[:success] = "Successfully updated..."
        format.html { redirect_to action: :option_type }
        format.js { @current_item = @option_type }
        # format.json { head :no_content }
      else
        format.html { render text: "error" }
      end
    end
  end

  def option_value
    @option_values = OptionValue.all
  end

  def option_value_update
    @option_value = OptionValue.find(option_value_params[:id])
    respond_to do |format|
      if @option_value.update(option_value_params)
        flash[:success] = "Successfully updated..."
        format.html { redirect_to action: :option_value }
        format.js { @current_item = @option_value }
        # format.json { head :no_content }
      else
        format.html { render text: "error" }
      end
    end
  end

  def category_update
    @category = Category.find(category_params[:id])
    respond_to do |format|
      if @category.update(category_params)
        flash[:success] = "Successfully updated..."
        format.html { redirect_to action: :category }
        format.js { @current_item = @category }
        # format.json { head :no_content }
      else
        format.html { render text: "error" }
      end
    end
    
  end

  def subcategory
    @subcategory = Subcategory.all
    @categories = Category.all
  end

  def subcategory_update
    @subcategory = Subcategory.find(subcategory_params[:id])
    respond_to do |format|
      if @subcategory.update(subcategory_params)
        flash[:success] = "Successfully updated..."
        format.html { redirect_to action: :subcategory }
        format.js { @current_item = @subcategory }
      else
        format.html { render text: "error" }
      end
    end
  end

  private
    def category_params
      params.require(:category).permit(:id, :menu_id, :name, :title, :url_name)
    end
    def option_value_params
      params.require(:option_value).permit(:id, :name, :title, :option_type_id)
    end
    def option_type_params
      params.require(:option_type).permit(:id, :name, :title)
    end
    def subcategory_params
      params.require(:subcategory).permit(:id, :name, :title, :url_name)      
    end
    
  
end
