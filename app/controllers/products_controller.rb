class ProductsController < ApplicationController
  before_action :category
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.paginate page: params[:page], order: 'title',
    per_page: params[:per_page] || 12

  end

  # GET /products/1
  # GET /products/1.json
  def show
    render template: 'products/index'
  end

  def show_category
    category_id = @category.find_by_url_name(params[:category]).id
    @category_name = Category.find_by_url_name(params[:category]).name
    @products =  Product.where(category_id: category_id).paginate(page: params[:page], order: 'title', per_page: 9)
    render template: 'products/index'
  end

  def show_subcategory
    subcategory_id = @subcategory.find_by_url_name(params[:subcategory]).id
    @subcategory_name = Subcategory.find_by_url_name(params[:subcategory]).name
    @category_name = Category.find_by_url_name(params[:category]).name
    @products =  Product.where(subcategory_id: subcategory_id).paginate(page: params[:page], order: 'title', per_page: 9)
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
      category_id = @category.find_by_url_name(params[:id]).id
      @products =  Product.where(category_id: category_id).paginate(page: params[:page], order: 'title', per_page: 9)
     end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end
end
