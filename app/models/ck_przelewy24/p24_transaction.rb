class CkPrzelewy24::P24Transaction < ActiveRecord::Base

  has_many :p24_confirmed_transactions, foreign_key: :p24_session_id, primary_key: :p24_session_id
  belongs_to :order, class_name: CkPrzelewy24.order_class

  validates :p24_merchant_id, presence: true
  validates :p24_pos_id, presence: true
  validates :p24_session_id, presence: true
  validates :p24_amount, presence: true
  validates :p24_currency, presence: true
  validates :p24_description, presence: true
  validates :p24_email, presence: true, email_format: true
  validates :p24_country, presence: true
  validates :p24_url_return, presence: true
  validates :p24_api_version, presence: true
  validates :p24_sign, presence: true

  def confirm
    update confirmed: true
  end
end
