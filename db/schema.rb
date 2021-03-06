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

ActiveRecord::Schema.define(version: 20160218162315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "answers", force: true do |t|
    t.string   "text"
    t.integer  "value"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exam_id"
    t.boolean  "reports_complete"
  end

  add_index "categories", ["exam_id"], name: "index_categories_on_exam_id", using: :btree

  create_table "category_reports", force: true do |t|
    t.integer  "category_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value_min"
    t.integer  "value_max"
  end

  add_index "category_reports", ["category_id"], name: "index_category_reports_on_category_id", using: :btree

  create_table "category_scores", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "score",       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_scores", ["category_id"], name: "index_category_scores_on_category_id", using: :btree
  add_index "category_scores", ["user_id"], name: "index_category_scores_on_user_id", using: :btree

  create_table "exams", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "exam_type"
  end

  add_index "exams", ["account_id"], name: "index_exams_on_account_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "text"
    t.string   "question_type"
    t.text     "long_answer"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "questions", ["category_id"], name: "index_questions_on_category_id", using: :btree
  add_index "questions", ["exam_id"], name: "index_questions_on_exam_id", using: :btree

  create_table "reports", force: true do |t|
    t.text     "text"
    t.text     "intro"
    t.text     "outro"
    t.integer  "user_id"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports", ["exam_id"], name: "index_reports_on_exam_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "scores", force: true do |t|
    t.integer  "score",              default: 0, null: false
    t.integer  "exam_id"
    t.integer  "user_id"
    t.integer  "questions_answered", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["exam_id"], name: "index_scores_on_exam_id", using: :btree
  add_index "scores", ["user_id"], name: "index_scores_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
