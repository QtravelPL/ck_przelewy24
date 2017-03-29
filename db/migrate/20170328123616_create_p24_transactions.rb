class CreateP24Transactions < ActiveRecord::Migration
  def change
    create_table :p24_transactions do |t|
      t.integer :order_id, null: false
      t.integer :p24_merchant_id, null: false
      t.integer :p24_pos_id, null: false
      t.string :p24_session_id, null: false
      t.integer :p24_amount, null: false
      t.string :p24_currency, null: false
      t.string :p24_description, null: false
      t.string :p24_email, null: false
      t.string :p24_client
      t.string :p24_address
      t.string :p24_zip
      t.string :p24_city
      t.string :p24_country, null: false
      t.string :p24_phone
      t.string :p24_language
      t.string :p24_method
      t.string :p24_url_return, null: false
      t.string :p24_url_status
      t.integer :p24_time_limit
      t.integer :p24_wait_for_result
      t.integer :p24_channel
      t.integer :p24_shipping
      t.string :p24_transfer_label
      t.string :p24_api_version, null: false
      t.string :p24_sign, null: false
      t.string :p24_encoding
      t.string :response
      t.boolean :confirmed, null: false, default: false
      t.timestamps
    end

    add_index :p24_transactions, :p24_session_id, unique: true
    add_index :p24_transactions, :p24_sign, unique: true
  end
end
