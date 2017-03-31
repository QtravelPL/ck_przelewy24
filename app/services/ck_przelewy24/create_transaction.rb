module CkPrzelewy24
  class CreateTransaction

    API_VERSION = "3.2"
    DEFAULT_TIME_LIMIT = 15
    DEFAULT_CURRENCY = "PLN"
    DEFAULT_COUNTRY = "PL"
    DEFAULT_ENCODING = "UTF-8"

    def initialize attributes
      @attributes = attributes
    end

    def call
      p24_transaction
    end

    private

    attr_reader :attributes

    def sign
      Digest::MD5.hexdigest("#{ session_id }|#{ merchant_id }|#{ amount }|#{ currency }|#{ crc }")
    end

    def merchant_id
      CkPrzelewy24.przelewy24_merchant_id
    end

    def crc
      CkPrzelewy24.przelewy24_crc
    end

    def currency
      attributes[:p24_currency] || DEFAULT_CURRENCY
    end

    protected

    def p24_transaction
      @p24_transaction ||= CkPrzelewy24::P24Transaction.create transation_params
    end

    def transation_params
      {
          p24_merchant_id: merchant_id,
          p24_pos_id: pos_id,
          p24_session_id: session_id,
          p24_amount: amount,
          p24_currency: currency,
          p24_description: description,
          p24_email: email,
          p24_client: client,
          p24_address: address,
          p24_zip: zip,
          p24_city: city,
          p24_language: language,
          p24_country: country,
          p24_phone: phone,
          p24_method: method,
          p24_url_return: url_return,
          p24_url_status: url_status,
          p24_time_limit: time_limit,
          p24_wait_for_result: wait_for_result,
          p24_channel: channel,
          p24_shipping: shipping,
          p24_transfer_label: transfer_label,
          p24_api_version: api_version,
          p24_sign: sign,
          p24_encoding: encoding,
          order: order,
      }
    end

    def pos_id
      merchant_id
    end

    def session_id
      @session_id ||= SecureRandom.hex
    end

    def amount
      (attributes[:p24_amount]*100).to_i
    end

    def description
      attributes[:p24_description]
    end

    def email
      attributes[:p24_email]
    end

    def client
      attributes[:p24_client]
    end

    def address
      attributes[:p24_address]
    end

    def zip
      attributes[:p24_zip]
    end

    def city
      attributes[:p24_city]
    end

    def phone
      attributes[:p24_phone].gsub(/\D/, '') if attributes[:p24_phone].present?
    end

    def language
      attributes[:p24_language] || DEFAULT_COUNTRY.downcase
    end

    def country
      attributes[:p24_country] || DEFAULT_COUNTRY
    end

    def method
    end

    def url_return
      attributes[:p24_url_return]
    end

    def url_status
      attributes[:p24_url_status]
    end

    def time_limit
      attributes[:p24_time_limit] || DEFAULT_TIME_LIMIT
    end
    # empty methods are optional params
    def wait_for_result
    end

    def channel
    end

    def shipping
    end

    def transfer_label
    end

    def api_version
      API_VERSION
    end

    def encoding
      DEFAULT_ENCODING
    end

    def order
      attributes[:order]
    end
  end
end
