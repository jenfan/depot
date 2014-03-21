class ProductsController < ApplicationController
  before_action :category
  before_action :set_product, only: [:index, :show, :edit, :update, :destroy]
  
  # GET /products
  # GET /products.json
  def index

  end

  # GET /products/1
  # GET /products/1.json
  def show
    render template: 'products/index'
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def category
      @category = Category.all
      @subcategory = Subcategory.all
    end

    def set_product
      @cart = current_cart
      if params[:category]!=nil 
      @category_name = @category.find_by_url_name(params[:category]).name
      
      category_id = @category.find_by_url_name(params[:category]).id
      @products = Product.where(category_id: category_id).search(params[:page])
        if params[:subcategory]!=nil
        @subcategory_name = @subcategory.find_by_url_name(params[:subcategory]).name
        subcategory_id = @subcategory.find_by_url_name(params[:subcategory]).id
        @products =  Product.where(subcategory_id: subcategory_id).search(params[:page])
        end
      else 
        @products=Product.search params[:page]
      end
     end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end
end
