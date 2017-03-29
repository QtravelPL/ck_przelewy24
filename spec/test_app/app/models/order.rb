class Order < ActiveRecord::Base

  has_one :p24_transaction, class_name: 'CkPrzelewy24::P24Transaction'

  validates :first_name, :last_name, :price, presence: true

end