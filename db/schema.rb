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

ActiveRecord::Schema.define(version: 20160525210822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shipping_requests", force: :cascade do |t|
    t.string   "origin_zip",      default: "98103", null: false
    t.string   "destination_zip",                   null: false
    t.integer  "number_of_items",                   null: false
    t.string   "estimates",                         null: false
    t.string   "chosen_type"
    t.string   "tracking_info"
    t.integer  "order_id",                          null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "country",         default: "USA",   null: false
  end

end
