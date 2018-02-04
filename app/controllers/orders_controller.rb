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
      subtotal += carted_product.product.price * carted_product.quantity
    end 

    tax = subtotal * 0.09

    total = tax + subtotal

    @order = Order.new(
                      user_id: current_user.id,
                      subtotal: subtotal,
                      tax: tax,
                      total: total
                      ) 
  end 

  @order.save
  carted_products.each { |carted_product| carted_product.update(status: "purchased")}
  render 'show.json.jbuilder'
  end 
end
