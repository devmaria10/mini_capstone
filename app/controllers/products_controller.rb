class ProductsController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]
  # before_action :authenticate_admin, except: [:index, :show]

  def index
    @products = Product.all

    search_term = params[:search]
    
    if search_term
      @products = @products.where("name iLike ?", "%#{search_term}%")
    end

    sort_attribute = params[:sort]
    
    if sort_attribute
      @products = @products.order(sort_attribute => :asc)
    end

    category_name = params[:category]
    if category_name
      @products = Category.find_by(name: category_name).products 
    end 
    render 'index.json.jbuilder'
  end

  def create
      @product = Product.new(
                            name: params[:name],
                            description: params[:description],
                            price: params[:price],
                            supplier_id: params[:supplier_id]
                            )
    if @product.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
    end
  end 

  def show
    @product = Product.find(params[:id])
    render 'show.json.jbuilder'
  end

  def update
    if current_user && current_user.admin
      @product = Product.find(params[:id])
    
      @product.name = params[:name] || @product.name
      @product.description = params[:description] || @product.description
      @product.price = params[:price] || @product.price
      @product.supplier_id = params[:supplier_id] || @product.supplier_id
    
      @product.save
        render 'show.json.jbuilder'
      else
        render json: {message: @product.errors.full_messages}, status: :unprocessable_entity
      end
  end 

  def destroy
    if current_user && current_user.admin
      product = Product.find(params[:id])
      product.destroy
      render json: {message: "Successfully destroyed product ##{product.id}"}
    end 
  end
end 