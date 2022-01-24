module CkPrzelewy24
  module Api
    class P24TransactionsController < CkPrzelewy24::ApplicationController

      require 'responders'

      skip_before_action :verify_authenticity_token
      respond_to :json

      def confirm
        CkPrzelewy24::ConfirmTransaction.new(confirmation_params).call
        head :ok
      end

      private

      def confirmation_params
        params.permit(:p24_merchant_id, :p24_pos_id, :p24_session_id, :p24_amount, :p24_currency, :p24_order_id,
                      :p24_method, :p24_statement, :p24_sign)

      end
    end
  end
end
