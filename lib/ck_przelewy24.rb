require "ck_przelewy24/engine"

module CkPrzelewy24

  mattr_accessor :order_class, :mailer_service_name, :przelewy24_url, :przelewy24_crc, :przelewy24_merchant_id
end
