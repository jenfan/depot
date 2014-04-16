class AdminController < ApplicationController
	layout 'admin/index'
  # skip_before_filter :verify_authenticity_token, :only => [:index, :show, :category, :category_update]
	# before_action :authenticate, only:

  def index
    #@products = Product.all
  end

  def output
    a = params.keys
    #params[params.keys[0]]
    cols = Product.columns
    data = Product.all
    buf = Hash.new
    for i in 0..cols.count-1
      buf.store(i, :name => cols[i].name, :checked => "0")
    end 
    puf=Hash.new
    ff= File.new("settings.rb", "w")
    ff.write(buf)
    ff.close
    file = File.read("settings.rb")
    for i in 0..file.scan("name").count-1
      puf.store(i, :name => file.scan(/(?:[a-z_])+/)[3*i+1], :checked => file.scan(/(?:[0-9])+/)[2*i+1])
    end
    art = Hash.new
    @data = Product.all
    j=0
    @data.each do |data|
    art.store(j, :string => data[buf[0][:name]])
    j+=1
    end
    render json: art
    

  end

  def products

    @orderlink = params[:orderlink]
    
    if params[:orderlink]!=nil
      search = params[:orderlink]
      ans = Hash.new
      data = Product.all
      for i in 0..data.count-1
        if data[i].title.scan(search)[0]!=nil
           ans[data[i].id]=data[i].title
        end
      end 
      @products = Product.where(id: ans.keys )
    else
      @products = Product.all
    end

  	
    if params[:mycheck]!=nil
      @str = 1
      @bool = true
    else
      @str = 0
      @bool = false
    end

    cols = Product.columns
    @buf = Hash.new
    file = File.read("settings.rb")
    for i in 0..file.scan("name").count-1
      @buf.store(i, :name => file.scan(/(?:[a-z_])+/)[3*i+1], :checked => file.scan(/(?:[0-9])+/)[2*i+1])
    end
    if params.count > 2
        for i in 0..cols.count-1
        if params[@buf[i][:name]]=="1"
          @buf.store(i, :name => cols[i].name, :checked => "1")
        else
          @buf.store(i, :name => cols[i].name, :checked => "0")
        end  
      end 
      puf=Hash.new
      f= File.new("settings.rb", "w")
      f.write(@buf)
      f.close
    end  

    
    
    







    @categories = Category.all.map { |n| [n.name, n.id] }
    @subcategories = Subcategory.all
    @interests = Interest.all.map { |n| [n.name, n.id] }
    # @option_values = product.option_values
    logger.info(params[:product])
  	# @products = Product.all.search(params[:page])
  end

  def add_product_option
    # option = add_product_option(Product_id, value_id)
  end

  def add_product_option_value
    
  end

  def interest
    @interests = Interest.all
  end

  def interest_create
    @interest_new = Interest.new(interest_params)
    @interest_new.save
    @interests = Interest.all
    render 'interest'
  end

  def interest_update
    @interest = Interest.find(interest_params[:id])
    flash[:success] = "Successfully updated..." if @interest.update(interest_params)
    render 'interest'
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

  def product_option_value
    @product_option_values = Product.find(1).product_option_values
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
    def interest_params
      params.require(:interest).permit(:id, :name)
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
