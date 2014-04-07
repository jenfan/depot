class StaticPagesController < ApplicationController
      before_action :category, :set_cart

      def about
      end

      def bonus
      end

      def contact
      end

      def help
      end

      def vopros
      end

      private
          # Use callbacks to share common setup or constraints between actions.

          def category
            @menu = Menu.includes(:categories).includes(:subcategories).all
            @current_menu = Menu.includes(:categories).find_by_permalink([params[:menu]]) if params[:menu]
            if @current_menu.nil? and params[:menu]
              redirect_to action: 'index'
              return
            end
            @current_category = @current_menu.categories.find_by_url_name(params[:category]) if params[:category]
            @current_subcategory = @current_category.subcategories.find_by_url_name(params[:subcategory]) if params[:subcategory]
          end

          def set_cart
            @cart = current_cart  
          end
end
