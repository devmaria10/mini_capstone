class CartedProductsController < ApplicationController
  def index
    @carted_product = current_user.carted_products.where(status: "carted")
    render 'index.json.jbuilder'
  end 

  def create
    @carted_product = CartedProduct.new(
                                        user_id: current_user.id,
                                        product_id: params[:product_id],
                                        quantity: params[:quantity],
                                        status: "carted"
                                        )
    @carted_product.save
    render 'show.json.jbuilder'
  end 

  def destroy
    carted_product = CartedProduct.find(params[:id])
    carted_product.destroy
    render json:{message: "Product #{carted_product.id} has been removed from your cart."}
  end 
end
