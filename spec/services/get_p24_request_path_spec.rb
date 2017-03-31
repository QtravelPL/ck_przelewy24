require 'rails_helper'
require 'factory_girl_rails'

describe CkPrzelewy24::GetP24RequestPath do

  let(:order) { FactoryGirl.create :order }

  let(:transaction_params) do
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

  let(:p24_transaction) { double "Przelewy24::P24Transaction" }
  let(:p24_create_transaction) { double "Przelewy24::CreateTransaction" }
  let(:p24_register_transaction) { double "Przelewy24::RegisterTransaction" }

  let(:response_token) { 123 }

  it "returns p24 request path" do
    expect(CkPrzelewy24::CreateTransaction).to receive(:new).and_return(p24_create_transaction)
    expect(p24_create_transaction).to receive(:call).and_return(p24_transaction)
    expect(CkPrzelewy24::RegisterTransaction).to receive(:new).and_return(p24_register_transaction)
    expect(p24_register_transaction).to receive(:call).and_return(p24_register_transaction).
        and_return("error=0&token=#{ response_token }")
    expect(p24_transaction).to receive(:valid?).and_return true

    path = "#{ CkPrzelewy24.przelewy24_url }/trnRequest/#{ response_token }"

    expect(CkPrzelewy24::GetP24RequestPath.new(transaction_params).call).to eq path
  end
end
