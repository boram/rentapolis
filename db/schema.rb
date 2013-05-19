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

ActiveRecord::Schema.define(version: 20130519212905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "rentals", force: true do |t|
    t.integer  "beds"
    t.decimal  "baths",                                                       precision: 2, scale: 1
    t.string   "unit_type"
    t.integer  "sqft"
    t.text     "description"
    t.decimal  "rent",                                                        precision: 6, scale: 2
    t.string   "rent_per"
    t.decimal  "deposit",                                                     precision: 6, scale: 2
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "projected_coordinates", limit: {:srid=>3785, :type=>"point"}
  end

  add_index "rentals", ["projected_coordinates"], :name => "index_rentals_on_projected_coordinates", :spatial => true

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.string   "url"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
