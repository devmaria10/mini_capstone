class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.find(params[:id])
    render 'show.json.jbuilder'
end
