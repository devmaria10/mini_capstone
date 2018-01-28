class Supplier < ApplicationRecord
  def products
    has_many :products
  end 
end
