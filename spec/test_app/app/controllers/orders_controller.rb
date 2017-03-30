class OrdersController < ApplicationController

  def index
    @order = Order.new
  end

  def create
    if Order.new(create_order_params).valid?
      redirect_to CkPrzelewy24.p24_request_path(transaction_params)
    else
      render :show
    end
  end

  private

  def order
    @order ||= Order.create!(create_order_params)
  end

  def create_order_params
    params.permit(:first_name, :last_name, :email, :phone, :price)
  end

  def transaction_params
    {
        order_price: order.price,
        transaction_description: 'test_description',
        order_email: order.email,
        url_return: "#{ CkPrzelewy24.site_url }/order_confirmation/#{ order.id }",
        client_name: order.first_name,
        client_phone: order.phone,
        order: order
    }
  end
end
