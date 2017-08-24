require 'rails_helper'

describe CkPrzelewy24::Api::P24TransactionsController do

  routes { CkPrzelewy24::Engine.routes }

  describe '#confirm' do

    let(:confirm_transaction) { double 'CkPrzelewy24::ConfirmTransaction' }

    let(:params) { ActionController::Parameters.new({ p24_merchant_id: "1",
                                                      p24_pos_id: "2",
                                                      p24_session_id: "123",
                                                      p24_amount: "123",
                                                      p24_currency: "PLN",
                                                      p24_order_id: "333",
                                                      p24_method: "23",
                                                      p24_statement: "123-123-123" ,
                                                      p24_sign: "test",
                                                    }).permit! }

    before do
      expect(CkPrzelewy24::ConfirmTransaction).to receive(:new).with(params).and_return(confirm_transaction)
      expect(confirm_transaction).to receive(:call).and_return(true)

      post :confirm, params: params.to_h.merge(format: :json)
    end

    it { is_expected.to respond_with(:ok) }
  end
end
