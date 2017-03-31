require 'rails_helper'
require 'factory_girl_rails'

describe CkPrzelewy24::CreateTransaction do

  let(:order) { FactoryGirl.build :order }

  let(:attributes) do
    {
        p24_amount: 123.45,
        p24_description: "Opis test 123...",
        p24_email: "customer@example.com",
        p24_client: "name",
        p24_address: "address",
        p24_zip: "zip",
        p24_city: "city",
        p24_phone: "123123123",
        p24_url_return: 'example.com',
        p24_url_status: "example.com/api/p24_transactions/confirm",
        order: order
    }
  end

  let(:create_attributes) do
    {
        p24_merchant_id: CkPrzelewy24.przelewy24_merchant_id,
        p24_pos_id: CkPrzelewy24.przelewy24_merchant_id,
        p24_session_id: "session_id",
        p24_amount: (attributes[:p24_amount]*100).to_i,
        p24_currency: CkPrzelewy24::CreateTransaction::DEFAULT_CURRENCY,
        p24_description: attributes[:p24_description],
        p24_email: attributes[:p24_email],
        p24_client: attributes[:p24_client],
        p24_address: attributes[:p24_address],
        p24_zip: attributes[:p24_zip],
        p24_city: attributes[:p24_city],
        p24_language: CkPrzelewy24::CreateTransaction::DEFAULT_COUNTRY.downcase,
        p24_country: CkPrzelewy24::CreateTransaction::DEFAULT_COUNTRY,
        p24_phone: attributes[:p24_phone],
        p24_method: nil,
        p24_url_return: attributes[:p24_url_return],
        p24_url_status: attributes[:p24_url_status],
        p24_time_limit: CkPrzelewy24::CreateTransaction::DEFAULT_TIME_LIMIT,
        p24_wait_for_result: nil,
        p24_channel: nil,
        p24_shipping: nil,
        p24_transfer_label: nil,
        p24_api_version: CkPrzelewy24::CreateTransaction::API_VERSION,
        p24_encoding: CkPrzelewy24::CreateTransaction::DEFAULT_ENCODING,
        order: order
    }
  end

  let(:create_attributes_with_sign) {
    create_attributes.merge(p24_sign: sign)
  }

  let(:crc) { CkPrzelewy24.przelewy24_crc }

  let(:sign) {
    Digest::MD5.hexdigest(
        "#{ create_attributes[:p24_session_id] }|#{ create_attributes[:p24_merchant_id] }|#{ create_attributes[:p24_amount] }|#{ create_attributes[:p24_currency] }|#{ crc }"
    )
  }

  let(:p24_transaction) { double "CkPrzelewy24::P24Transaction" }

  describe "#call" do

    it "creates transaction when attributes are correct" do
      expect(CkPrzelewy24::P24Transaction).to receive(:create).with(create_attributes_with_sign).and_return(p24_transaction)
      expect(SecureRandom).to receive(:hex).and_return(create_attributes[:p24_session_id])

      expect(CkPrzelewy24::CreateTransaction.new(attributes).call).to be p24_transaction
    end

    it "returns invalid object when attributes are incorrect" do
      invalid_p24_transaction = CkPrzelewy24::CreateTransaction.new(attributes.except(:p24_description)).call
      expect(invalid_p24_transaction).to be_kind_of CkPrzelewy24::P24Transaction
      expect(invalid_p24_transaction.valid?).to be_falsey
    end
  end
end
