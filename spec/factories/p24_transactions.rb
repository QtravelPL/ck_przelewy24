FactoryGirl.define do
  factory :p24_transaction, class: 'CkPrzelewy24::P24Transaction' do
    session_id = SecureRandom.hex
    merchant_id = 12345
    amount = 1234
    currency = 'PLN'
    crc = Rails.application.secrets.przelewy24_crc

    order_id 1
    p24_merchant_id merchant_id
    p24_pos_id 54321
    p24_session_id session_id
    p24_amount amount
    p24_currency currency
    p24_description 'Description123...'
    p24_email 'customer@example.com'
    p24_country 'PL'
    p24_url_return 'http://localhost:3000'
    p24_api_version '3.2'
    p24_sign Digest::MD5.hexdigest("#{ session_id }|#{ merchant_id }|#{ amount }|#{ currency }|#{ crc }")
  end
end
