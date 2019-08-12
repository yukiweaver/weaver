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

ActiveRecord::Schema.define(version: 2019_08_12_023502) do

  create_table "expenses", force: :cascade do |t|
    t.integer "ecategory_id"
    t.string "enote"
    t.date "edate"
    t.integer "emoney"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "highlight"
    t.index ["user_id", "created_at"], name: "index_expenses_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer "icategory"
    t.string "inote"
    t.date "idate"
    t.integer "imoney"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_incomes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.boolean "admin", default: false
    t.string "provider"
    t.string "uid"
    t.string "user_name"
    t.string "image_url"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
