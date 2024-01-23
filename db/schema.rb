# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_01_23_071703) do
  create_table "attempts", force: :cascade do |t|
    t.string "email"
    t.integer "count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "combinations", force: :cascade do |t|
    t.text "positions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "hashed_combination"
    t.string "salt"
    t.index ["user_id"], name: "index_combinations_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.text "sender_account_number"
    t.text "receiver_account_number"
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "title"
    t.string "address"
    t.string "name"
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.decimal "money", precision: 10, scale: 2, default: "10000.0", null: false
    t.string "id_number"
    t.string "account_no"
    t.integer "password_length"
    t.string "card_number"
    t.string "last_used_combination"
    t.integer "last_used_combination_id"
    t.text "last_used_combination_positions"
    t.index ["account_no"], name: "index_users_on_account_no", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "combinations", "users"
  add_foreign_key "transfers", "users"
end
