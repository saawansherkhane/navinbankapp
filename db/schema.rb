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

ActiveRecord::Schema.define(version: 20171214071326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_transactions", force: :cascade do |t|
    t.integer  "to_account"
    t.integer  "from_account"
    t.float    "amount",       default: 0.0
    t.integer  "account_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "description"
    t.index ["account_id"], name: "index_account_transactions_on_account_id", using: :btree
  end

  create_table "accounts", force: :cascade do |t|
    t.float    "balance",     default: 0.0
    t.integer  "customer_id"
    t.boolean  "status"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["customer_id"], name: "index_accounts_on_customer_id", using: :btree
  end

  create_table "branches", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "email_id"
    t.integer  "phone"
    t.integer  "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "status"
    t.index ["branch_id"], name: "index_customers_on_branch_id", using: :btree
  end

  add_foreign_key "account_transactions", "accounts"
  add_foreign_key "accounts", "customers"
  add_foreign_key "customers", "branches"
end
