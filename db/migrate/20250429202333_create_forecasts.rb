class CreateForecasts < ActiveRecord::Migration[8.0]
  def up
    create_table :forecasts do |t|
      t.string :units, null: false, default: "metric"

      t.string :icon
      t.string :condition
      t.decimal :temperature
      t.decimal :feels_like
      t.decimal :wind_speed
      t.decimal :wind_degree
      t.string :wind_direction
      t.decimal :pressure
      t.decimal :visibility
      t.decimal :uv_index
      t.decimal :heat_index
      t.decimal :dew_point
      t.decimal :cloud_cover
      t.decimal :gust_speed
      t.integer :humidity
      t.decimal :uv
      t.decimal :wind_chill
      t.decimal :precipitation

      t.integer :days_count, default: 0

      t.references :city, null: false, foreign_key: true

      t.datetime :fetched_at

      t.timestamps
    end

    add_index :forecasts, [ :city_id, :units ], name: "index_forecasts_on_city_id_and_units"
  end

  def down
    drop_table :forecasts, force: :cascade if table_exists?(:forecasts)
  end
end
