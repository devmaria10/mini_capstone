class OrdersController < ApplicationController
  before_action :authenticate_user

  def index
    @orders = Order.all
    render 'index.json.jbuilder'
  end 

  def create
    @carted_products = current_user.carted_products.where(status: "carted")
    

    subtotal = 0
    carted_products.each do |carted_product|
      subtotal += carted_product.subtotal 
    end 

    tax = subtotal * 0.09

    total = tax + subtotal

    @order = Order.new(
                      user_id: current_user.id,
                      ) 

    subtotal = 0
    carted_products.each do |carted_product|
      subtotal += carted_product.subtotal
  end 

  @order.subtotal = subtotal
  @order.tax = @order.subtotal * 0.09
  @order.total = @order.tax + @order.subtotal

  @order.save
  carted_products.each { |carted_product| carted_product.update(status: "purchased")}
  render 'show.json.jbuilder'
  end 

  def destroy
    carted_product = CartedProduct.find(params[:id])
    # carted_product.status = "removed"
    # carted_product.save
    carted_product.update(status: "removed")
    render json: {message: "Product removed from cart"}
  end 
end
