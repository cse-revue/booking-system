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

ActiveRecord::Schema.define(version: 20140925092555) do

  create_table "booked_seats", force: true do |t|
    t.integer  "booking_id"
    t.integer  "seat_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "booking_statistics", force: true do |t|
    t.integer  "booking_id"
    t.integer  "user_id"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", force: true do |t|
    t.integer "performance_id"
    t.string  "name"
    t.string  "email"
    t.string  "guid"
  end

  create_table "performances", force: true do |t|
    t.string   "name"
    t.integer  "production_id"
    t.datetime "start"
    t.text     "prices"
  end

  create_table "productions", force: true do |t|
    t.string  "pretitle"
    t.string  "title"
    t.string  "webname"
    t.text    "description"
    t.string  "contact_email"
    t.string  "ticket_cc_email"
    t.integer "theatre_id"
  end

  create_table "seats", force: true do |t|
    t.string  "name"
    t.integer "x"
    t.integer "y"
    t.float   "percent_x"
    t.float   "percent_y"
    t.integer "segment_id"
  end

  create_table "segments", force: true do |t|
    t.string  "name"
    t.integer "height"
    t.integer "theatre_id"
  end

  create_table "theatres", force: true do |t|
    t.string  "name"
    t.string  "webname"
    t.integer "width"
  end

  create_table "unavailable_seats", force: true do |t|
    t.string  "seat"
    t.integer "performance_id"
  end

  create_table "user_productions", force: true do |t|
    t.integer "user_id"
    t.integer "production_id"
    t.boolean "manager"
  end

  create_table "users", force: true do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "phone"
    t.string "session_key"
  end

end
