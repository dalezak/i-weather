class Forecast
  include ActiveModel::Model
  include ActiveModel::Attributes

  FIELDS = {
    "Condition" => :condition,
    "Temperature" => :temperature,
    "Feels Like" => :feels_like,
    "Wind Speed" => :wind_speed,
    "Wind Direction" => :wind_direction,
    "Pressure" => :pressure,
    "Visibility" => :visibility,
    "UV Index" => :uv_index,
    "Heat Index" => :heat_index,
    "Dew Point" => :dew_point,
    "Cloud Cover" => :cloud_cover,
    "Gust Speed" => :gust_speed,
    "Humidity" => :humidity,
    "Precipitation" => :precipitation,
    "Updated" => :updated_at,
    "Cached" => :cached_at
  }.freeze

  attribute :updated_at, :datetime
  attribute :cached_at, :datetime

  attribute :location_name, :string
  attribute :location_region, :string
  attribute :location_country, :string

  attribute :icon, :string
  attribute :condition, :string

  attribute :temperature, :string
  attribute :feels_like, :string
  
  attribute :wind_speed, :string
  attribute :wind_direction, :string

  attribute :pressure, :string
  attribute :visibility, :string

  attribute :uv_index, :string
  attribute :heat_index, :string

  attribute :dew_point, :string
  attribute :cloud_cover, :string

  attribute :gust_speed, :string

  attribute :humidity, :string
  attribute :precipitation, :string

end
