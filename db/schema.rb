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

ActiveRecord::Schema[7.1].define(version: 2024_03_09_052106) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "vote_change_logs", force: :cascade do |t|
    t.bigint "vote_id"
    t.bigint "old_candidate_id"
    t.bigint "new_candidate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["new_candidate_id"], name: "index_vote_change_logs_on_new_candidate_id"
    t.index ["old_candidate_id"], name: "index_vote_change_logs_on_old_candidate_id"
    t.index ["vote_id"], name: "index_vote_change_logs_on_vote_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "candidate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_votes_on_candidate_id"
    t.index ["user_id"], name: "index_votes_on_user_id", unique: true
  end

  add_foreign_key "vote_change_logs", "candidates", column: "new_candidate_id"
  add_foreign_key "vote_change_logs", "candidates", column: "old_candidate_id"
  add_foreign_key "vote_change_logs", "votes"
  add_foreign_key "votes", "candidates"
  add_foreign_key "votes", "users"
end
