class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.save

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def order_params
    params.required(:order).permit(:quantity, :color, :date_needed_by, :widget_type)
  end
end
