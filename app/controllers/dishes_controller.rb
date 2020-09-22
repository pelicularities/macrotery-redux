class DishesController < ApplicationController

    def index
        @dish = Dish.all
    end

    def show
        @dish = Dish.find(params[:id])
    end
end
