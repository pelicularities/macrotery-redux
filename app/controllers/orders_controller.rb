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
        @order = Order.new(orders_params)
    end

    private

    def orders_params
        params.require(:order).permit(:dine_in, :preferred_time, :confirmed)
    end
end
