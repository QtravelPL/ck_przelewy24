require 'rails_helper'

describe CkPrzelewy24::Przelewy24Gateway do

  describe "#register_transaction" do

    let(:p24_transaction) { create :p24_transaction }
    let(:response) { "error=0&token=123" }

    before do
      WebMock.stub_request(:post, "#{ Rails.application.secrets.przelewy24_url }/trnRegister").
          to_return(status: 200, body: response, headers: {})
    end

    it "gets transaction token" do
      expect(CkPrzelewy24::Przelewy24Gateway.new.register_transaction(p24_transaction).body).to eq response
    end
  end

  describe "#verify_transaction" do

    let(:p24_confirmed_transaction) { create :p24_confirmed_transaction }
    let(:response) { "error=0" }

    before do
      WebMock.stub_request(:post, "#{ Rails.application.secrets.przelewy24_url }/trnVerify").
          to_return(status: 200, body: response, headers: {})
    end

    it "verifies transaction" do
      expect(CkPrzelewy24::Przelewy24Gateway.new.verify_transaction(p24_confirmed_transaction).body).to eq response
    end
  end
end
