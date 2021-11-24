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

ActiveRecord::Schema.define(version: 2021_11_21_131419) do

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.date "birthday"
    t.integer "user_id"
    t.integer "species_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["species_id"], name: "index_pets_on_species_id"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "pets_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.boolean "confirmed", default: false
    t.string "confirmation_token"
    t.string "password_digest"
    t.boolean "avatar", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "recover_password"
  end

  add_foreign_key "pets", "species"
  add_foreign_key "pets", "users"
end
