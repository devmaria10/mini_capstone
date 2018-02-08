class CartedProduct < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true 
  belongs_to :product 

  def calculate_subtotal
    sum = 0

    carted_products.each do |carted_product|
      sum += carted_product.subtotal
    self.subtotal = sum
    end 

  end 
end
