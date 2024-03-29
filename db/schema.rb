# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140215064400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: true do |t|
    t.string "name"
  end

  create_table "comments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "text"
  end

  create_table "submissions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id"
    t.string   "link"
    t.datetime "submitted_at"
    t.string   "feelings"
    t.text     "submitter_comments"
    t.integer  "assignment_id"
  end

  create_table "users", force: true do |t|
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "provider"
    t.string   "type",                           null: false
    t.string   "name"
    t.string   "gh_nickname",                    null: false
    t.string   "avatar_url"
    t.integer  "squad_leader_id"
    t.string   "first_name"
  end

  add_index "users", ["gh_nickname"], name: "index_users_on_gh_nickname", unique: true, using: :btree
  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

end
