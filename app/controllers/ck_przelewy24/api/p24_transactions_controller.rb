module CkPrzelewy24
  module Api
    class P24TransactionsController < CkPrzelewy24::ApplicationController

      require 'responders'
      require 'apipie-rails'
      extend Apipie::DSL::Concern

      skip_before_action :verify_authenticity_token
      respond_to :json

      # api! 'Create Przelewy24::ConfirmedTransaction and confirms Przelewy24::Transaction'
      param :p24_merchant_id, :number, require: true
      param :p24_pos_id, :number, require: true
      param :p24_session_id, String, require: true
      param :p24_amount, :number, require: true
      param :p24_currency, String, require: true
      param :p24_order_id, :number, require: true
      param :p24_method, :number, require: true
      param :p24_statement, String, require: true
      param :p24_sign, String, require: true

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
