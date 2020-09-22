class OrderDishesController < ApplicationController

    # def index
    #     @order_dish = Order_dish.all
    # end

    # def show
    #     @order_dish = Order_dish.find(params[:id])
    # end

    def update
        @order_dish.update(order_dish_params)
        @order_dish.save

    end

    def create
        @order_dish = Order_dish.new(order_dish_params)
    end

    def destroy
        @order_dish.destroy
    end

    private

    def order_dish_params
        params.require(:order_dish).permit(:quantity)
    end
end
