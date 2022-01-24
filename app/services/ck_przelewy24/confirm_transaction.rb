module CkPrzelewy24
  class ConfirmTransaction < CkPrzelewy24::CreateTransaction

    def call
      if confirmation_sign? && p24_confirmed_transaction
        confirm.tap { verify_transaction && run_callback_service }
      end
    end

    private

    def run_callback_service
      callback_service.new(p24_transaction.order_id).call if CkPrzelewy24.service_name_call_after_confirmation.present?
    end

    def verify_transaction
      @verify_transaction ||= CkPrzelewy24::VerifyTransaction.new(p24_confirmed_transaction).call
    end

    def confirm
      p24_transaction.confirm
    end

    def p24_confirmed_transaction
      @p24_confirmed_transaction ||= CkPrzelewy24::P24ConfirmedTransaction.create!(attributes)
    end

    def p24_transaction
      @p24_transaction ||= CkPrzelewy24::P24Transaction.find_by!(p24_transaction_params)
    end

    def confirmation_sign?
      attributes[:p24_sign] == confirmation_sign
    end

    def confirmation_sign
      Digest::MD5.hexdigest("#{ session_id }|#{ order_id }|#{ amount }|#{ currency }|#{ crc }")
    end

    def p24_transaction_params
      {
          p24_session_id: session_id,
          p24_sign: sign
      }
    end

    def session_id
      attributes[:p24_session_id]
    end

    def amount
      attributes[:p24_amount]
    end

    def order_id
      attributes[:p24_order_id]
    end

    def callback_service
      CkPrzelewy24.service_name_call_after_confirmation.constantize
    end
  end
end
