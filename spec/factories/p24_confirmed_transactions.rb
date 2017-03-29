FactoryGirl.define do
  factory :p24_confirmed_transaction, class: 'CkPrzelewy24::P24ConfirmedTransaction' do
    session_id = SecureRandom.hex
    order_id = 123
    amount = 1234
    currency = 'PLN'
    crc = CkPrzelewy24.przelewy24_crc

    p24_merchant_id 12345
    p24_pos_id 54321
    p24_session_id session_id
    p24_amount amount
    p24_currency currency
    p24_order_id order_id
    p24_method 20
    p24_statement "123-123-123"
    p24_sign Digest::MD5.hexdigest("#{ session_id }|#{ order_id }|#{ amount }|#{ currency }|#{ crc }")
  end
end
