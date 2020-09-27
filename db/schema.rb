# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_27_140212) do

  create_table "buy_histories", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "player_id", null: false
    t.integer "amount", null: false
    t.integer "buy_price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "change_histories", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "new_value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_change_histories_on_player_id"
  end

  create_table "dividends", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "amount", null: false
    t.string "detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_dividends_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.string "team", null: false
    t.string "position", null: false
    t.string "country", null: false
    t.integer "age", null: false
    t.integer "height", null: false
    t.integer "weight", null: false
    t.integer "sell_price", null: false
    t.integer "buy_price", null: false
    t.integer "remaining_stock", default: 0, null: false
    t.integer "border_stock", default: 100, null: false
    t.string "image_name"
    t.decimal "price", precision: 10, scale: 5, null: false
  end

  create_table "sell_histories", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "player_id", null: false
    t.integer "amount", null: false
    t.integer "sell_price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_stocks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "player_id", null: false
    t.integer "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_user_stocks_on_player_id"
    t.index ["user_id"], name: "index_user_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "phone", null: false
    t.string "user_name", null: false
    t.date "birthday", null: false
    t.boolean "notification", null: false
    t.string "invitation_code"
    t.integer "point", default: 0
    t.string "public_uid"
    t.datetime "last_login"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["public_uid"], name: "index_users_on_public_uid", unique: true
  end

  create_table "watches", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_watches_on_player_id"
    t.index ["user_id"], name: "index_watches_on_user_id"
  end

end
