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

ActiveRecord::Schema[7.0].define(version: 2022_12_09_143642) do
  create_table "leads", force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "firstname"
    t.string "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "phone"], name: "index_leads_on_email_and_phone", unique: true
  end

  create_table "requests", force: :cascade do |t|
    t.integer "annual_revenue"
    t.string "entreprise_no"
    t.string "legal_name"
    t.boolean "natural_person"
    t.string "nacebel_codes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lead_id"
    t.index ["lead_id"], name: "index_requests_on_lead_id"
  end

  add_foreign_key "requests", "leads"
end
