require 'rails_helper'
require 'factory_girl_rails'

describe CkPrzelewy24::ConfirmTransaction do

  let(:attributes) do
    {
        p24_merchant_id: CkPrzelewy24.przelewy24_merchant_id,
        p24_order_id: 333,
        p24_amount: 12345,
        p24_currency: "PLN",
        p24_session_id: "session_id",
    }
  end

  let(:crc) { CkPrzelewy24.przelewy24_crc }
  let(:attributes_with_sign) { attributes.merge(p24_sign: sign(attributes[:p24_order_id])) }

  let(:p24_transaction_find_params) do
    {
        p24_session_id: attributes[:p24_session_id],
        p24_sign: sign(attributes[:p24_merchant_id])
    }
  end

  let(:p24_confirmed_transaction) { double "CKPrzelewy24::P24ConfirmedTransaction" }
  let(:p24_transaction) { double "CKPrzelewy24::P24Transaction" }
  let(:przelewy24_verify_transaction) { double "CKPrzelewy24::VerifyTransaction"}

  let(:callback_service_after_confirmation) { double CkPrzelewy24.service_name_call_after_confirmation }

  describe "#call" do

    it "confirms transaction when attributes are correct" do
      expect(CkPrzelewy24::P24ConfirmedTransaction).to receive(:create!).with(attributes_with_sign).and_return(p24_confirmed_transaction)

      expect(CkPrzelewy24::P24Transaction).to receive(:find_by!).with(p24_transaction_find_params).and_return(p24_transaction)
      expect(p24_transaction).to receive(:confirm).and_return(true)
      expect(p24_transaction).to receive(:order_id).and_return(p24_transaction)

      expect(CkPrzelewy24.service_name_call_after_confirmation.constantize).to receive(:new).with(p24_transaction).and_return(callback_service_after_confirmation)
      expect(callback_service_after_confirmation).to receive(:call).and_return(true)

      expect(CkPrzelewy24::VerifyTransaction).to receive(:new).with(p24_confirmed_transaction).and_return(przelewy24_verify_transaction)
      expect(przelewy24_verify_transaction).to receive(:call).and_return(przelewy24_verify_transaction)

      CkPrzelewy24::ConfirmTransaction.new(attributes_with_sign).call
    end

    it "returns nil when sign is incorrect" do
      expect(CkPrzelewy24::ConfirmTransaction.new(attributes).call).to eq nil
    end
  end

  def sign second_attribut
    Digest::MD5.hexdigest(
        "#{ attributes[:p24_session_id] }|#{ second_attribut }|#{ attributes[:p24_amount] }|#{ attributes[:p24_currency] }|#{ crc }"
    )
  end
end
