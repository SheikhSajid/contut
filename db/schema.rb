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

ActiveRecord::Schema.define(version: 20160920050517) do

  create_table "accepteds", force: :cascade do |t|
    t.integer  "tutor_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "tutor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "certificates", force: :cascade do |t|
    t.integer  "tutor_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "tutor_id"
    t.integer  "student_id"
    t.text     "message"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "sender_tutor"
    t.boolean  "sender_student"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "tutor_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.integer  "rating"
    t.integer  "tutor_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "city"
    t.string   "area"
    t.integer  "zip"
    t.text     "full_address"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "gender"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.string   "encrypted_password",           default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",              default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "email",                        default: "", null: false
    t.string   "institution"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "students", ["confirmation_token"], name: "index_students_on_confirmation_token", unique: true
  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  add_index "students", ["unlock_token"], name: "index_students_on_unlock_token", unique: true

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.string   "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tutor_id"
  end

  create_table "tutors", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "gender"
    t.integer  "rate"
    t.text     "description"
    t.string   "city"
    t.string   "area"
    t.integer  "zip"
    t.text     "full_address"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "phone"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.string   "degree"
    t.string   "institution"
    t.integer  "year"
    t.string   "curr_employer"
    t.string   "position"
    t.string   "encrypted_password",           default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",              default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "email",                        default: "",    null: false
    t.string   "name",                                         null: false
    t.boolean  "approved",                     default: false
    t.boolean  "pending_approval",             default: false
    t.float    "avg",                          default: 0.0
    t.integer  "no_of_reviews",                default: 0
  end

  add_index "tutors", ["confirmation_token"], name: "index_tutors_on_confirmation_token", unique: true
  add_index "tutors", ["email"], name: "index_tutors_on_email", unique: true
  add_index "tutors", ["reset_password_token"], name: "index_tutors_on_reset_password_token", unique: true
  add_index "tutors", ["unlock_token"], name: "index_tutors_on_unlock_token", unique: true

end
