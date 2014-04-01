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

ActiveRecord::Schema.define(version: 20140331224835) do

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_name"
    t.integer  "menu_id"
  end

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   default: 1
  end

  create_table "menus", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.decimal  "articul"
    t.string   "title"
    t.string   "proizvoditel"
    t.decimal  "price",                 precision: 8, scale: 2
    t.decimal  "price_discount",        precision: 8, scale: 2
    t.decimal  "price_second",          precision: 8, scale: 2
    t.decimal  "price_second_discount", precision: 8, scale: 2
    t.decimal  "kol_v_upakovke",        precision: 8, scale: 0
    t.string   "category"
    t.string   "subcategory"
    t.decimal  "discount"
    t.boolean  "hit"
    t.boolean  "is_show"
    t.decimal  "vsego"
    t.decimal  "reserv"
    t.decimal  "svobod_ostatok"
    t.boolean  "is_new"
    t.text     "description"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.integer  "menu_id"
  end

  create_table "subcategories", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_name"
    t.integer  "menu_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
