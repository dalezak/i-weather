class CreateCities < ActiveRecord::Migration[8.0]
  def up
    create_table :cities do |t|
      t.string :name, null: false
      t.string :region, null: false
      t.string :country, null: false

      t.integer :forecasts_count, default: 0

      t.timestamps
    end

    add_index :cities, [ :name, :region ], unique: true
  end

  def down
    drop_table :cities, force: :cascade if table_exists?(:cities)
  end
end
