class StoreController < ApplicationController
	before_action :show_count_session, only: [:index]
  def index
  	@products = Product.paginate page: params[:page], order: 'title',
    per_page: params[:per_page] || 12
  	@cart = current_cart
  	session[:count]+=1
  end
end
