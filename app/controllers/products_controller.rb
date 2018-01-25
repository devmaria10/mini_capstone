class ProductsController < ApplicationController
  def index
    products = Product.all

    search_term = params[:search]

    if search_term 
      products = products.where("name iLIKE ?", "%#{search_term}%")
    end

    sort_attribute = params[:sort]

    if sort_attribute
      products = products.order(sort_attribute)
    end 

    render json: products.as_json
  end 

  def create
    product = Product.new(
                          name: params[:name],
                          price: params[:chef],
                          image_url: params[:image_url],
                          description: params[:description]
                          )
    if product.save
      render json: product.as_json 
    else 
      render json: { errors: product.errors.full_messages}, status: :unprocessable_entity
    end 
  end 

  def show
    product = Product.find(params[:id])
    render json: product.as_json 
  end 

  def update
    product = Product.find(params[:id])
    
    product.name = params[:name]
    product.price = params[:price]
    product.image_url = params[:image_url]
    product.description = params[:description]
    
    if product.save 
      render json: product.as_json 
    else 
      render json: {message: product.errors.full_messages}, status: :unprocessable_entity
    end 
    
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: { message: "Successfully deleted Product ##{product.id}." }
  end  
end
