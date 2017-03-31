module CkPrzelewy24
  class RegisterTransaction

    def initialize p24_transaction
      @p24_transaction = p24_transaction
    end

    def call
      register_transaction.tap { update_response }
    end

    private

    attr_reader :p24_transaction

    def update_response
      p24_transaction.update(response: register_transaction)
    end

    def register_transaction
      @register_transaction ||= CkPrzelewy24::Przelewy24Gateway.new.register_transaction(p24_transaction)
    end
  end
end
