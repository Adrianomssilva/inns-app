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

ActiveRecord::Schema[7.1].define(version: 2023_11_03_012243) do
  create_table "inns", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_number"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "state"
    t.string "city"
    t.string "cep"
    t.integer "owner_id", null: false
    t.text "description"
    t.string "paymente_options"
    t.string "pets"
    t.text "policies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_inns_on_owner_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  add_foreign_key "inns", "owners"
end