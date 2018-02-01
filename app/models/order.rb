class Order < ApplicationRecord
  belongs_to :user 
  belongs_to :product

  def calculate_subtotal
    self.subtotal = product.price * quantity
  end

  def calculate_tax
    self.tax = subtotal * 0.09
  end 

  def calculate_total
    self.total = tax + subtotal 
  end 
end
