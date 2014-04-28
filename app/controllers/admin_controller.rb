class AdminController < ApplicationController
	layout 'admin/index'
  # skip_before_filter :verify_authenticity_token, :only => [:index, :show, :category, :category_update]
	# before_action :authenticate, only:

  def index
    #@products = Product.all
    @product = Product.first
    # @properties = @product.property_values.includes(:property)
    @properties = @product.prototype.properties
    #@properties_val_prop_vals = PropertiesValue.properties
    @properties_all = Property.all
    @prototypes = Prototype.all
    @prot_prop = PrototypeProperty.all
    
  end

  def jsmeth
    ff= File.new("lastcell.rb", "w")
    ff.write(params[:lastid]+params[:lastname])
    ff.close 
  end  

  def jscript
    begin
      file = File.read("lastcell.rb")
    rescue 
      ff= File.new("lastcell.rb", "w")
      ff.close
    end    
    @lastid=file.scan(/(?:[0-9])+/)[0]
    @lastname=file.scan(/(?:[a-z_])+/)[0]
    if params[:addr]==nil
      @openflag = 0
      @id = params[:lid]
      @name = params[:lname]
    else
      @openflag = 1
      @id = params[:lid]
      @name = params[:lname]
      @newcell = params[:addr]
      ff= File.new("change.rb", "w")
      ff.write(params[:cellchange])
      ff.close
      current_product = Product.find_by_id(@id.to_i)
      current_product.update_attributes(@name => params[:cellchange]) 
    end  
    products()

  end

  def output
    @id="1"
    @name="title"
    current_product = Product.find_by_id(@id.to_i)
      #current_product[@name].update_attributes(@name params[:cellchange]) 
    render json:  @name.to_sym
    

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
    
    cols = Product.columns
    @buf = Hash.new
    file = File.read("settings.rb")
    for i in 0..file.scan("name").count-1
      @buf.store(i, :name => file.scan(/(?:[a-z_])+/)[3*i+1], :checked => file.scan(/(?:[0-9])+/)[2*i+1])
    end
    if params.count > 2 && params[:cellchange]==nil
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
  end

  def category
    @menu = Menu.all
    @category = Category.all
    @subcategory = Subcategory.all



    #@category = Category.all
    #@menu = Menu.all.map { |m| [m.name, m.id] }
  end

  def categoryjs
    @menu = Menu.all
    @category = Category.all
    @subcategory = Subcategory.all
    
    
    if params[:menu]!=nil
      @mycat = @category.find_all_by_menu_id(@menu.find_by_id(params[:menu].to_i).id)
      @mnum = params[:menu]
      @check = params[:check]
    end
    if params[:category]!=nil
      @mysub = @subcategory.find_all_by_category_id(@category.find_by_id(params[:category].to_i).id)
      @catcheck = params[:catcheck]
      @catnum = params[:category]
    end
    @render=params[:render]
    
    
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

  def prototype
    @prototypes = Prototype.includes(:properties).all
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
