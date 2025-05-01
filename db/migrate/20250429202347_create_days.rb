class CreateDays < ActiveRecord::Migration[8.0]
  def up
    drop_table :days, force: :cascade if table_exists?(:days)
    create_table :days do |t|
      t.string :units, null: false, default: "metric"

      t.date :date

      t.string :icon
      t.string :condition
      t.decimal :max_temp
      t.decimal :min_temp
      t.decimal :avg_temp
      t.decimal :max_wind
      t.decimal :total_precipitation
      t.decimal :avg_visibility
      t.decimal :avg_humidity

      t.references :forecast, null: false, foreign_key: true

      t.timestamps
    end

    add_index :days, [ :forecast_id, :units, :date ], name: "index_days_on_forecast_id_and_units_and_date"
  end

  def down
    drop_table :days, force: :cascade if table_exists?(:days)
  end
end
