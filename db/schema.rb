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

ActiveRecord::Schema[7.1].define(version: 2024_07_08_134648) do
  create_table "cards", force: :cascade do |t|
    t.string "card_name"
    t.string "card_supertype"
    t.string "card_subtypes"
    t.string "card_set"
    t.string "card_rarity"
    t.string "card_image"
    t.integer "set_id", null: false
    t.integer "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_cards_on_item_id"
    t.index ["set_id"], name: "index_cards_on_set_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "card_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_items_on_card_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "order_total"
    t.integer "order_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "province_name"
    t.integer "provincial_tax"
    t.integer "federal_tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sets", force: :cascade do |t|
    t.string "set_name"
    t.string "set_series"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.integer "admin"
    t.integer "province_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id"], name: "index_users_on_province_id"
  end

  add_foreign_key "cards", "items"
  add_foreign_key "cards", "sets"
  add_foreign_key "items", "cards"
  add_foreign_key "orders", "users"
  add_foreign_key "users", "provinces"
end
