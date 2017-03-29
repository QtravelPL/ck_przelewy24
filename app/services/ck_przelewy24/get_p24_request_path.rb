module CkPrzelewy24
  class GetP24RequestPath

    def initialize transaction_params
      @transaction_params = transaction_params
    end

    def call
      p24_request_path if p24_transaction.valid? && response_token.present?
    end

    attr_reader :transaction_params

    def p24_request_path
      "#{ CkPrzelewy24.przelewy24_url }/trnRequest/#{ response_token }"
    end

    def response_token
      Rack::Utils.parse_query(register_transaction).symbolize_keys[:token]
    end

    def register_transaction
      @register_transaction ||= CkPrzelewy24::RegisterTransaction.new(p24_transaction).call
    end

    def p24_transaction
      @p24_transaction ||= CkPrzelewy24::CreateTransaction.new(create_transaction_params).call
    end

    def create_transaction_params
      {
          p24_amount: transaction_params[:order_price],
          p24_description: transaction_params[:transaction_description],
          p24_email: transaction_params[:order_email],
          p24_url_return: transaction_params[:url_return],
          p24_url_status: CkPrzelewy24::Engine.routes.url_helpers.confirm_api_p24_transactions_url(host: CkPrzelewy24.site_url),
          p24_client: transaction_params[:client_name],
          p24_phone: transaction_params[:client_phone],
          order: transaction_params[:order]
      }
    end
  end
end
