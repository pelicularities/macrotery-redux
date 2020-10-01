class EateriesController < ApplicationController
  
  def show
    @eatery = Eatery.find(params[:id])
    @order = Order.new
    @protein = params[:protein]
    @carbs = params[:carbs]
    @fats = params[:fats]
  end
end
