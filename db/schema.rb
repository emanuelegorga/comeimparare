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

ActiveRecord::Schema.define(version: 2022_01_29_234608) do

  # These are extensions that must be enabled in order to support this database
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
    t.text "summary"
    t.float "average_rating", default: 0.0, null: false
    t.index ["difficulty"], name: "index_courses_on_difficulty"
    t.index ["language"], name: "index_courses_on_language"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "joins", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "course_id", null: false
    t.uuid "user_id", null: false
    t.integer "rating"
    t.text "review"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_joins_on_course_id"
    t.index ["user_id"], name: "index_joins_on_user_id"
  end

  create_table "lectures", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.uuid "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_lectures_on_course_id"
  end

  create_table "progress_tracks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "lecture_id", null: false
    t.uuid "user_id", null: false
    t.integer "views", default: 0, null: false
    t.index ["lecture_id"], name: "index_progress_tracks_on_lecture_id"
    t.index ["user_id"], name: "index_progress_tracks_on_user_id"
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
  add_foreign_key "joins", "courses"
  add_foreign_key "joins", "users"
  add_foreign_key "lectures", "courses"
  add_foreign_key "progress_tracks", "lectures"
  add_foreign_key "progress_tracks", "users"
end
