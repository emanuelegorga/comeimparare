ActiveRecord::Schema.define(version: 2022_01_29_162332) do
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "courses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "difficulty", default: 0, null: false
    t.integer "language", default: 0, null: false
    t.integer "price", default: 0, null: false
    t.jsonb "metadata", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_id", null: false
    t.index ["difficulty"], name: "index_courses_on_difficulty"
    t.index ["language"], name: "index_courses_on_language"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_digest"
    t.string "avatar_url"
    t.string "platform", default: "local"
    t.boolean "is_admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["is_admin"], name: "index_users_on_is_admin"
    t.index ["platform"], name: "index_users_on_platform"
  end

  add_foreign_key "courses", "users"
end
