class OrdersController < ApplicationController

  def index
    @orders = Order.all
    render 'index.json.jbuilder'
  end 

  def create
    subtotal = Product.find(params[:product_id]).price * params[:quantity].to_i
    tax = subtotal * 0.9
    total = tax + subtotal

    @order = Order.new(
                        user_id: current_user.id,
                        product_id: params[:product_id],
                        quantity: params[:quantity],
                        subtotal: subtotal,
                        tax: tax,
                        total: total
                      ) 
  end 

  @order.save
    render 'show.json.jbuilder'
  end 
end
