class CategoriesController < ApplicationController
  def index
    @categories = Category.all 
    render 'index.json.jbuilder'
end
