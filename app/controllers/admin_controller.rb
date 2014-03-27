class AdminController < ApplicationController
	layout 'admin/index'
	# before_action :authenticate, only:

  def index
  	
  end

  def products
  	@products = Product.all
  	# @products = Product.all.search(params[:page])
  end

  def category
  	@category = Category.all
  end

  def category_update
    @category = Category.find(category_params[:id])
    respond_to do |format|
      if @category.update(category_params)
        flash[:success] = "Successfully updated..."
        format.html { redirect_to action: :category }
        # format.json { head :no_content }
      else
        format.html { render text: "error" }
      end
    end
    
  end

  def subcategory
    @subcategory = Subcategory.all
  end

  def subcategory_update
    @subcategory = Subcategory.find(subcategory_params[:id])
    respond_to do |format|
      if @subcategory.update(subcategory_params)
        flash[:success] = "Successfully updated..."
        format.html { redirect_to action: :subcategory }
        # format.json { head :no_content }
      else
        format.html { render text: "error" }
      end
    end
  end

  private
    def category_params
      params.require(:category).permit(:id, :name, :title, :url_name)
    end
    def subcategory_params
      params.require(:subcategory).permit(:id, :name, :title, :url_name)      
    end
  
end
