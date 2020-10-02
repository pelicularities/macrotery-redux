class OrdersController < ApplicationController

    def index
        @orders = current_user.orders
    end

    def show
        @order = current_user.orders.find(params[:id])
    end

    def new
        @order = Order.new
    end

    def create
        @order = Order.create(user: current_user, dine_in: params[:order][:dine_in])
        params[:order_dishes].each do |key, value|
          if value[:quantity].to_i >= 1
            @dish = Dish.find(key.to_i)
            OrderDish.create(order: @order, dish: @dish, quantity: value[:quantity].to_i)
            @order.amount_cents += @dish.price_cents * value[:quantity].to_i
          end
        end

        @order.save


        if @order.id
          session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            line_items: [{
              name: "your order",
              amount: @order.amount_cents,
              currency: 'sgd',
              quantity: 1
            }],
            success_url: order_url(@order),
            cancel_url: order_url(@order)
            )

          @order.update(checkout_session_id: session.id)
          redirect_to order_path(@order)
        else
            redirect_to eatery_path
        end
    end

    private

    def orders_params
        params.require(:order_dishes).permit(:order, :dine_in, :preferred_time, :confirmed)
    end
end
