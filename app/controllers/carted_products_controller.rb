class CartedProductsController < ApplicationController
  def create
    @carted_product = CartedProduct.new(
                                        product_id: params[:product_id],
                                        quantity: params[:quantity]
                                        )
    if @carted_product.save
      @carted_product()
  end 
end
