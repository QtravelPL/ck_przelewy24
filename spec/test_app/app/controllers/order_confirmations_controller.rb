class OrderConfirmationsController < ApplicationController

  def show
    @payment_confirmed = Order.find(order[:id]).p24_transaction.confirmed?
  end

  def order
    params.permit(:id)
  end
end