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

ActiveRecord::Schema.define(version: 20140423194802) do

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

  create_table "interests", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
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

  create_table "option_types", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "option_values", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "option_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "option_values", ["option_type_id"], name: "index_option_values_on_option_type_id"

  create_table "orders", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_option_values", force: true do |t|
    t.integer  "product_id"
    t.integer  "option_value_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_option_values", ["option_value_id"], name: "index_product_option_values_on_option_value_id"
  add_index "product_option_values", ["product_id"], name: "index_product_option_values_on_product_id"

  create_table "products", force: true do |t|
    t.decimal  "articul"
    t.string   "title"
    t.string   "proizvoditel"
    t.decimal  "price",                           precision: 8, scale: 2
    t.decimal  "price_discount",                  precision: 8, scale: 2
    t.decimal  "price_second",                    precision: 8, scale: 2
    t.decimal  "price_second_discount",           precision: 8, scale: 2
    t.integer  "kol_v_upakovke",        limit: 8
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
    t.integer  "interest_id"
    t.integer  "prototype_id"
  end

  add_index "products", ["interest_id"], name: "index_products_on_interest_id"

  create_table "properties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_values", force: true do |t|
    t.integer  "property_id"
    t.integer  "product_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prototype_properties", force: true do |t|
    t.integer  "property_id"
    t.integer  "prototype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prototypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
