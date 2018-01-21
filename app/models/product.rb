class Product < ApplicationRecord
  
  def is_discounted
    price < 25
  end

  def tax
    price * 0.09
  end 

  def total
    price + tax
  end 

  def as_json
    {
    id: id,
    name: name,
    image_url: image_url,
    price: price,
    description: description,
    is_discounted: is_discounted,
    tax: tax,
    total: total
    }
  end 
end
