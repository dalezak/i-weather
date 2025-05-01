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

ActiveRecord::Schema[8.0].define(version: 2025_04_29_202347) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "region", null: false
    t.string "country", null: false
    t.integer "forecasts_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "region"], name: "index_cities_on_name_and_region", unique: true
  end

  create_table "days", force: :cascade do |t|
    t.string "units", default: "metric", null: false
    t.date "date"
    t.string "icon"
    t.string "condition"
    t.decimal "max_temp"
    t.decimal "min_temp"
    t.decimal "avg_temp"
    t.decimal "max_wind"
    t.decimal "total_precipitation"
    t.decimal "avg_visibility"
    t.decimal "avg_humidity"
    t.bigint "forecast_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forecast_id", "units", "date"], name: "index_days_on_forecast_id_and_units_and_date"
    t.index ["forecast_id"], name: "index_days_on_forecast_id"
  end

  create_table "forecasts", force: :cascade do |t|
    t.string "units", default: "metric", null: false
    t.string "icon"
    t.string "condition"
    t.decimal "temperature"
    t.decimal "feels_like"
    t.decimal "wind_speed"
    t.decimal "wind_degree"
    t.string "wind_direction"
    t.decimal "pressure"
    t.decimal "visibility"
    t.decimal "uv_index"
    t.decimal "heat_index"
    t.decimal "dew_point"
    t.decimal "cloud_cover"
    t.decimal "gust_speed"
    t.integer "humidity"
    t.decimal "uv"
    t.decimal "wind_chill"
    t.decimal "precipitation"
    t.integer "days_count", default: 0
    t.bigint "city_id", null: false
    t.datetime "fetched_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id", "units"], name: "index_forecasts_on_city_id_and_units"
    t.index ["city_id"], name: "index_forecasts_on_city_id"
  end

  add_foreign_key "days", "forecasts"
  add_foreign_key "forecasts", "cities"
end
