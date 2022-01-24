class CreateP24ConfirmedTransactions < ActiveRecord::Migration[4.2]
  def change
    create_table :p24_confirmed_transactions do |t|
      t.integer :p24_merchant_id, null: false
      t.integer :p24_pos_id, null: false
      t.string :p24_session_id, null: false, index: true
      t.integer :p24_amount, null: false
      t.string :p24_currency, null: false
      t.string :p24_order_id, null: false
      t.string :p24_method, null: false
      t.string :p24_statement, null: false
      t.string :p24_sign, null: false
      t.string :response
      t.boolean :verified, null: false, default: false
      t.timestamps
    end
  end
end
