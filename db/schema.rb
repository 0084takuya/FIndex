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

ActiveRecord::Schema.define(version: 2020_09_20_120721) do

  create_table "buy_history", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "player_id", null: false
    t.integer "amount", null: false
    t.integer "buy_price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.integer "ask_price", null: false
    t.integer "buy_price", null: false
  end

  create_table "sell_history", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "player_id", null: false
    t.integer "amount", null: false
    t.integer "sell_price", null: false
    t.integer "buy_price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
