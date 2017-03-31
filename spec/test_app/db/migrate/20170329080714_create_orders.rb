class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.string :phone
      t.decimal :price, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
