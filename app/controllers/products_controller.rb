class ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :category
  before_action :set_product, only: [:index, :show, :edit, :update, :destroy]
  
  # GET /products
  # GET /products.json

  def index
    @products ||= Product.search params[:page]
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @subcategories = @product.category.subcategories.map { |cat| [cat.name, cat.id]}
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
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        # format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        flash[:success] = "Successfully updated..."
        format.html { redirect_to action: :products, controller: :admin }
        # format.json { head :no_content }
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
      @menu = Menu.all
      @category = Category.all
      @subcategory = Subcategory.all
    end

    def set_product
      @cart = current_cart
        if params[:category]
          @current_category = @category.find_by_url_name(params[:category])
          if @current_category
            @products = @current_category.products.search(params[:page]) 
            @current_subcategory = @subcategory.find_by_url_name(params[:subcategory])
            if @current_subcategory
              @products =  @current_subcategory.products.search(params[:page]) 
            end
          else
            @product = Product.find(params[:category])
            redirect_to product_path(@product) if @product
          end
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :category_id, :subcategory_id)
    end

    def record_not_found
      # flash.now[:notice] = "Товар или категория товаров не найдены"  
      redirect_to action: 'index'
    end

end
