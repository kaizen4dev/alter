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

ActiveRecord::Schema[8.1].define(version: 2026_07_23_143907) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "digest", null: false
    t.string "name", null: false
    t.boolean "revoked", default: false, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.float "all_chapters"
    t.string "author"
    t.integer "category", default: 0
    t.datetime "created_at", null: false
    t.string "picture_url"
    t.float "read_chapters"
    t.integer "status", default: 0
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "finance_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "currency"
    t.integer "group", default: 0
    t.string "name"
    t.float "sum"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_finance_accounts_on_user_id"
  end

  create_table "finance_transfers", force: :cascade do |t|
    t.float "amount"
    t.datetime "created_at", null: false
    t.string "currency"
    t.bigint "destination_id"
    t.float "fee"
    t.string "note"
    t.bigint "source_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["destination_id"], name: "index_finance_transfers_on_destination_id"
    t.index ["source_id"], name: "index_finance_transfers_on_source_id"
    t.index ["user_id"], name: "index_finance_transfers_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "links_tags", id: false, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "link_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_links_tags_on_link_id"
    t.index ["tag_id"], name: "index_links_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "access_tokens", "users"
  add_foreign_key "books", "users"
  add_foreign_key "finance_accounts", "users"
  add_foreign_key "finance_transfers", "finance_accounts", column: "destination_id"
  add_foreign_key "finance_transfers", "finance_accounts", column: "source_id"
  add_foreign_key "finance_transfers", "users"
  add_foreign_key "links", "users"
  add_foreign_key "links_tags", "links"
  add_foreign_key "links_tags", "tags"
  add_foreign_key "tags", "users"
end
