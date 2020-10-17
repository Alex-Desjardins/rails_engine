ActiveRecord::Schema.define(version: 2020_10_17_225453) do

  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.integer "csv_id"
    t.string "first_name"
    t.string "last_name"
    t.string "created_at"
    t.string "updated_at"
  end

end
