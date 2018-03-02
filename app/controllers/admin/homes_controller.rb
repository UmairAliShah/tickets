class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user_from_token!, :raise => false
  before_action :product_detail, only: [:show]
  def index
    @user = User.all.count
    @products = Product.all.count
    @unapproved_products = Product.where(:approve => false).count
    @approved_products = Product.where(:approve => true).count
  end

  def approved_products
    @all_approved_products = Product.where(:approve => true)
  end


  def unapproved_products
    @all_unapproved_products = Product.where(:approve => false)
  end

  def show
  end

  private
   # Use callbacks to share common setup or constraints between actions.
   def product_detail
     @product = Product.find(params[:id])
     @product_features = @product.features
     @product_images = @product.images
   end
end
