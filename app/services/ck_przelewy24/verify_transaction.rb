module CkPrzelewy24
  class VerifyTransaction

    def initialize p24_confirmed_transaction
      @p24_confirmed_transaction = p24_confirmed_transaction
    end

    def call
      set_as_verified if update_response
    end

    private

    attr_reader :p24_confirmed_transaction

    def verify_transaction
      @verify_transaction ||= CkPrzelewy24::Przelewy24Gateway.new.verify_transaction(p24_confirmed_transaction)
    end

    def update_response
      p24_confirmed_transaction.update(response: verify_transaction)
    end

    def set_as_verified
      p24_confirmed_transaction.set_as_verified if no_errors
    end

    def no_errors
      Rack::Utils.parse_query(verify_transaction).symbolize_keys[:error] == "0"
    end
  end
end