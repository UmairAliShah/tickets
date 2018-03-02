class ProductsController < ApplicationController
  before_action do
    if current_user != nil
      authenticate_user!
    else
      authenticate_admin!
    end
  end

  skip_before_action :authenticate_user_from_token!, :raise => false
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    #3.times do
    #    question = @survey.questions.build
    #    4.times { question.answers.build }
    #end
    @product.images.build
    3.times{
      @features = @product.features.build
    }

  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    debugger
    @product = Product.new(product_params)
    if user_signed_in?
      @product.imageable_id = current_user.id
      @product.imageable_type = "User"
    elsif admin_signed_in?
      @product.imageable_id = current_admin.id
      @product.imageable_type = "Admin"
      @product.approve = true
    end
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Your Product is pended to be saved till Admin's Approval."  }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
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
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def approve_product
    
      @product = Product.find(params[:id])
      if @product
         @product.approve = true
          if @product.save
             flash[:notice] = "Successfully Approved!"
          else
             flash[:notice] = "Not Approved!"
          end
      end
      redirect_to admin_homes_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :total_tickets, :sold_tickets, :short_description, :long_description, :approve, :count_down,  :user_id, :admin_id,
                                       images_attributes: [:id, :avatar, :product_id],
                                       features_attributes: [:id, :title, :content1, :content2, :content3, :content4, :content5, :product_id])#, contents_attributes: [:id, :value, :feature_id] ])
    end
end
