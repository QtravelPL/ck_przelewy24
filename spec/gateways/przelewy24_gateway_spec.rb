require 'rails_helper'
require 'factory_girl_rails'

describe CkPrzelewy24::Przelewy24Gateway do

  describe "#register_transaction" do

    let(:p24_transaction) { FactoryGirl.create :p24_transaction }
    let(:response) { "error=0&token=123" }

    subject(:register_transaction) { described_class.new.register_transaction(p24_transaction) }

    context 'success response' do

      before do
        WebMock.stub_request(:post, "#{ CkPrzelewy24.przelewy24_url }/trnRegister").
            to_return(status: 200, body: response, headers: {})
      end

      it "gets transaction token" do
        expect(register_transaction.body).to eq response
      end
    end

    context 'unsuccessful response' do

      before do
        WebMock.stub_request(:post, "#{ CkPrzelewy24.przelewy24_url }/trnRegister").
            to_return(status: 500, body: response, headers: {})
      end

      it "raises an error" do
        expect { register_transaction }.to raise_error(CkPrzelewy24::Przelewy24Gateway::UnsuccessfulResponse)
      end
    end
  end

  describe "#verify_transaction" do

    let(:p24_confirmed_transaction) { FactoryGirl.create :p24_confirmed_transaction }
    let(:response) { "error=0" }

    subject(:verify_transaction) { described_class.new.verify_transaction(p24_confirmed_transaction) }

    context 'success response' do

      before do
        WebMock.stub_request(:post, "#{ CkPrzelewy24.przelewy24_url }/trnVerify").
            to_return(status: 200, body: response, headers: {})
      end

      it "verifies transaction" do
        expect(verify_transaction.body).to eq response
      end
    end

    context 'unsuccessful response' do

      before do
        WebMock.stub_request(:post, "#{ CkPrzelewy24.przelewy24_url }/trnVerify").
            to_return(status: 500, body: response, headers: {})
      end

      it "raises an error" do
        expect { verify_transaction }.to raise_error(CkPrzelewy24::Przelewy24Gateway::UnsuccessfulResponse)
      end
    end
  end
end
