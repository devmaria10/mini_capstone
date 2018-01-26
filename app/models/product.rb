class Product < ApplicationRecord
  validates :name, presence:true
  validates :name, uniqueness:true
  validates :price, presence:true
  validates :description, numericality: { greater_than: 0 }
  validates :description, length: { in: 10..500 }

  def is_discounted
    price < 25
  end

  def tax
    price * 0.09
  end 

  def total
    price + tax
  end 

end
