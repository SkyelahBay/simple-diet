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

ActiveRecord::Schema.define(version: 2018_11_15_041449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fitness_events", force: :cascade do |t|
    t.bigint "user_id"
    t.string "event_title", null: false
    t.string "event_type", null: false
    t.integer "event_duration", default: 0, null: false
    t.string "event_meal_occurence", default: "0", null: false
    t.integer "event_calories", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_fitness_events_on_user_id"
  end

  create_table "fitness_goals", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "current_age", null: false
    t.integer "current_weight", null: false
    t.integer "current_height", null: false
    t.string "gender", null: false
    t.integer "activity_rating", null: false
    t.integer "desired_weight", null: false
    t.integer "current_calories", default: 0, null: false
    t.integer "recommended_calories", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_fitness_goals_on_user_id"
  end

  create_table "metrics_tables", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "total_calories_burned", default: 0, null: false
    t.integer "total_calories_gained", default: 0, null: false
    t.integer "record_calories_burned", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_metrics_tables_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.string "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
