ActiveRecord::Schema[7.0].define(version: 2022_12_08_143416) do
  create_table "simulations", force: :cascade do |t|
    t.integer "annual_revenue"
    t.string "entreprise_no"
    t.string "legal_name"
    t.boolean "natural_person"
    t.string "nacebel_codes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
