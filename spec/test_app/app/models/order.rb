class Order < ActiveRecord::Base

  # has_many :order_products, dependent: :destroy
  # has_one :p24_transaction

  validates :first_name, :last_name, :price, presence: true

end