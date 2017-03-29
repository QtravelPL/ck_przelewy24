module CkPrzelewy24
  class P24ConfirmedTransaction < ActiveRecord::Base

    self.table_name = "p24_confirmed_transactions"

    belongs_to :p24_transaction, foreign_key: :p24_session_id, primary_key: :p24_session_id
    has_many :p24_dispatched_transactions, foreign_key: :p24_order_id, primary_key: :p24_order_id

    delegate :order, to: :p24_transaction

    validates :p24_merchant_id, presence: true
    validates :p24_pos_id, presence: true
    validates :p24_session_id, presence: true
    validates :p24_amount, presence: true
    validates :p24_currency, presence: true
    validates :p24_order_id, presence: true
    validates :p24_method, presence: true
    validates :p24_statement, presence: true
    validates :p24_sign, presence: true

    def set_as_verified
      update verified: true
    end
  end
end