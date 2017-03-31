require 'rails_helper'
require 'factory_girl_rails'

describe CkPrzelewy24::RegisterTransaction do

  let(:p24_transaction) { FactoryGirl.create :p24_transaction }
  let(:przelewy24_gateway) { double "CkPrzelewy24::Przelewy24Gateway"}
  let(:response) { "response" }

  describe "#call" do

    it "calls Przelewy24Gateway.register_transaction and updates p24_transaction" do
      expect(CkPrzelewy24::Przelewy24Gateway).to receive(:new).and_return(przelewy24_gateway)
      expect(przelewy24_gateway).to receive(:register_transaction).with(p24_transaction).and_return response

      expect(p24_transaction.response).to be nil

      CkPrzelewy24::RegisterTransaction.new(p24_transaction).call

      expect(p24_transaction.response).to eq response
    end
  end
end
