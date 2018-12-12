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

ActiveRecord::Schema.define(version: 2018_12_12_140106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cryptocurrencies", force: :cascade do |t|
    t.string "ticker_name"
    t.string "ticker_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "cryptocurrency_id"
    t.decimal "crypto_amount_held", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cryptocurrency_id"], name: "index_portfolios_on_cryptocurrency_id"
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "top_ups", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "fiat_amount_cents", default: 0, null: false
    t.jsonb "payment"
    t.integer "transaction_type"
    t.datetime "date_of_top_up"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["user_id"], name: "index_top_ups_on_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.integer "transaction_type", default: 0, null: false
    t.bigint "user_id"
    t.bigint "cryptocurrency_id"
    t.integer "fiat_price_cents", default: 0, null: false
    t.integer "fiat_amount_cents", default: 0, null: false
    t.decimal "cryptocurrency_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date_of_trade"
    t.index ["cryptocurrency_id"], name: "index_trades_on_cryptocurrency_id"
    t.index ["user_id"], name: "index_trades_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "country"
    t.integer "fiat_balance_cents", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "portfolios", "cryptocurrencies"
  add_foreign_key "portfolios", "users"
  add_foreign_key "top_ups", "users"
  add_foreign_key "trades", "cryptocurrencies"
  add_foreign_key "trades", "users"
end
