require 'httparty'

module CkPrzelewy24
  class Przelewy24Gateway

    class UnsuccessfulResponse < StandardError
      def initialize(params, response)
        super("Unsuccessful Przelewy24 response (status: #{ response.code }) when fetching data for params: #{ params }")
      end
    end

    include HTTParty
    logger Rails.logger

    base_uri przelewy24_url

    def register_transaction p24_transaction
      @p24_transaction = p24_transaction
      response = self.class.post("/trnRegister", body: register_body)

      raise(UnsuccessfulResponse.new(register_body, response)) unless response.success?
    end

    def verify_transaction p24_confirmed_transaction
      @p24_confirmed_transaction = p24_confirmed_transaction
      response = self.class.post("/trnVerify", body: verify_body)

      raise(UnsuccessfulResponse.new(verify_body, response)) unless response.success?
    end

    private

    attr_reader :p24_transaction, :p24_confirmed_transaction

    def register_body
      p24_transaction.attributes.except("id", "created_at", "updated_at", "response", "confirmed", "order_id")
    end

    def verify_body
      p24_confirmed_transaction.attributes.except("id", "p24_method", "p24_statement", "created_at",
                                                  "updated_at", "response", "verified")
    end

    def przelewy24_url
      ENV["PRZELEWY24_URL"]
    end
  end
end
