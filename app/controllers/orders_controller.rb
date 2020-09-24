class OrdersController < ApplicationController

    def index
        @order = Order.all
    end

    def show
        @order = Order.find(params[:id])
    end

    def new
        @order = Order.new
    end

    def create
        order = Order.new(orders_params)
        order.user = current_user
        if order.save
            redirect_to order_path(order)
        else
            redirect_to eatery_path
        end
    end

    private

    def orders_params
        params.require(:order_dishes).permit(:order, :dine_in, :preferred_time, :confirmed)
    end
end
