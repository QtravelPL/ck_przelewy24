require "ck_przelewy24/engine"

module CkPrzelewy24

  mattr_accessor :order_class, :service_name_call_after_confirmation, :przelewy24_url, :przelewy24_crc, :przelewy24_merchant_id, :site_url

  def self.p24_request_path transaction_params
    CkPrzelewy24::GetP24RequestPath.new(transaction_params).call
  end
end
