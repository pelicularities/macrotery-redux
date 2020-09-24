class EateriesController < ApplicationController
  
  def show
    @eatery = Eatery.find(params[:id])
    @order = Order.new
  end
end
