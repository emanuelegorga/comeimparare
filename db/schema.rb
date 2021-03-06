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

ActiveRecord::Schema.define(version: 2022_02_05_101835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_storage_attachments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.boolean "accepted"
    t.boolean "published", default: false
    t.integer "profit", default: 0, null: false
    t.integer "joins_count", default: 0, null: false
    t.integer "lectures_count", default: 0, null: false
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
    t.integer "remarks_count", default: 0, null: false
    t.integer "progress_tracks_count", default: 0, null: false
    t.index ["course_id"], name: "index_lectures_on_course_id"
  end

  create_table "orders", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.integer "total", default: 0
    t.text "courses", default: [], array: true
    t.string "payment_method"
    t.datetime "paid_at", precision: 6
    t.json "metadata", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "progress_tracks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "lecture_id", null: false
    t.uuid "user_id", null: false
    t.integer "views", default: 0, null: false
    t.index ["lecture_id"], name: "index_progress_tracks_on_lecture_id"
    t.index ["user_id"], name: "index_progress_tracks_on_user_id"
  end

  create_table "remarks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "lecture_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecture_id"], name: "index_remarks_on_lecture_id"
    t.index ["user_id"], name: "index_remarks_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.uuid "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_digest"
    t.string "avatar_url"
    t.string "platform", default: "local"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "balance", default: 0, null: false
    t.integer "course_profit", default: 0, null: false
    t.integer "join_costs", default: 0, null: false
    t.integer "courses_count", default: 0, null: false
    t.integer "joins_count", default: 0, null: false
    t.integer "progress_tracks_count", default: 0, null: false
    t.integer "remarks_count", default: 0, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.json "metadata", default: {}
    t.index ["email"], name: "index_users_on_email"
    t.index ["platform"], name: "index_users_on_platform"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.uuid "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "courses", "users"
  add_foreign_key "joins", "courses"
  add_foreign_key "joins", "users"
  add_foreign_key "lectures", "courses"
  add_foreign_key "orders", "users"
  add_foreign_key "progress_tracks", "lectures"
  add_foreign_key "progress_tracks", "users"
  add_foreign_key "remarks", "lectures"
  add_foreign_key "remarks", "users"
end
