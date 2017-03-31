require 'rails_helper'
require 'factory_girl_rails'

describe CkPrzelewy24::VerifyTransaction do

  let(:p24_confirmed_transaction) { FactoryGirl.create :p24_confirmed_transaction }
  let(:przelewy24_gateway) { double "CkPrzelewy24::Przelewy24Gateway"}

  let(:response) { "error=0" }

  describe "#call" do

    it "calls Przelewy24Gateway.verify_transaction and sets verified as true" do
      expect(CkPrzelewy24::Przelewy24Gateway).to receive(:new).and_return(przelewy24_gateway)
      expect(przelewy24_gateway).to receive(:verify_transaction).with(p24_confirmed_transaction).and_return response

      expect(p24_confirmed_transaction.verified).to be_falsey
      expect(p24_confirmed_transaction.response).to be nil

      CkPrzelewy24::VerifyTransaction.new(p24_confirmed_transaction).call

      expect(p24_confirmed_transaction.verified).to be_truthy
      expect(p24_confirmed_transaction.response).to eq response
    end

    it "calls Przelewy24Gateway.verify_transaction and does not set verified as true when response has errors" do
      response = "error=1&error1=error"
      expect(CkPrzelewy24::Przelewy24Gateway).to receive(:new).and_return(przelewy24_gateway)
      expect(przelewy24_gateway).to receive(:verify_transaction).with(p24_confirmed_transaction).and_return response

      expect(p24_confirmed_transaction.verified).to be_falsey
      expect(p24_confirmed_transaction.response).to be nil

      CkPrzelewy24::VerifyTransaction.new(p24_confirmed_transaction).call

      expect(p24_confirmed_transaction.verified).to be_falsey
      expect(p24_confirmed_transaction.response).to eq response
    end
  end
end
