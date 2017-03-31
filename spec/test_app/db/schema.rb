# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170329080714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "email"
    t.string   "phone"
    t.decimal  "price",      precision: 10, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "p24_confirmed_transactions", force: :cascade do |t|
    t.integer  "p24_merchant_id",                 null: false
    t.integer  "p24_pos_id",                      null: false
    t.string   "p24_session_id",                  null: false
    t.integer  "p24_amount",                      null: false
    t.string   "p24_currency",                    null: false
    t.string   "p24_order_id",                    null: false
    t.string   "p24_method",                      null: false
    t.string   "p24_statement",                   null: false
    t.string   "p24_sign",                        null: false
    t.string   "response"
    t.boolean  "verified",        default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "p24_confirmed_transactions", ["p24_session_id"], name: "index_p24_confirmed_transactions_on_p24_session_id", using: :btree

  create_table "p24_transactions", force: :cascade do |t|
    t.integer  "order_id",                            null: false
    t.integer  "p24_merchant_id",                     null: false
    t.integer  "p24_pos_id",                          null: false
    t.string   "p24_session_id",                      null: false
    t.integer  "p24_amount",                          null: false
    t.string   "p24_currency",                        null: false
    t.string   "p24_description",                     null: false
    t.string   "p24_email",                           null: false
    t.string   "p24_client"
    t.string   "p24_address"
    t.string   "p24_zip"
    t.string   "p24_city"
    t.string   "p24_country",                         null: false
    t.string   "p24_phone"
    t.string   "p24_language"
    t.string   "p24_method"
    t.string   "p24_url_return",                      null: false
    t.string   "p24_url_status"
    t.integer  "p24_time_limit"
    t.integer  "p24_wait_for_result"
    t.integer  "p24_channel"
    t.integer  "p24_shipping"
    t.string   "p24_transfer_label"
    t.string   "p24_api_version",                     null: false
    t.string   "p24_sign",                            null: false
    t.string   "p24_encoding"
    t.string   "response"
    t.boolean  "confirmed",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "p24_transactions", ["p24_session_id"], name: "index_p24_transactions_on_p24_session_id", unique: true, using: :btree
  add_index "p24_transactions", ["p24_sign"], name: "index_p24_transactions_on_p24_sign", unique: true, using: :btree

end
