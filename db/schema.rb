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

ActiveRecord::Schema.define(version: 20151101123841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "backups", force: :cascade do |t|
    t.string   "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "quantity"
    t.integer  "item_id"
    t.string   "item_type"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

<<<<<<< HEAD
=======
  create_table "donations", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "notification_params"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "paid_at"
  end

  add_index "donations", ["user_id"], name: "index_donations_on_user_id", using: :btree

  create_table "nifty_attachments", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "token"
    t.string   "digest"
    t.string   "role"
    t.string   "file_name"
    t.string   "file_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nifty_key_value_store", force: :cascade do |t|
    t.integer "parent_id"
    t.string  "parent_type"
    t.string  "group"
    t.string  "name"
    t.string  "value"
  end

>>>>>>> 4824a4971816ccb084b635d90bbbc9b0798f7adb
  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "store_item_id"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["store_item_id"], name: "index_order_items_on_store_item_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.string   "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "notification_params"
    t.string   "transaction_id"
    t.datetime "purchased_at"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "store_items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "price"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "status"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "gender"
    t.string   "salutation"
    t.date     "birthdate"
    t.string   "username"
    t.string   "about"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "carts", "users"
  add_foreign_key "donations", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "store_items"
  add_foreign_key "orders", "users"
  add_foreign_key "posts", "users"
end
