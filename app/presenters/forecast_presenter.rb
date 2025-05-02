class ForecastPresenter < ApplicationPresenter
  attr_reader :forecast, :units

  # Mapping of field names to their corresponding attributes
  # This mapping is used to convert the field names from the API response to the attributes in the model
  FIELDS = {
    "Current" => :icon,
    "Condition" => :condition,
    "Temperature" => :temperature,
    "Feels Like" => :feels_like,
    "Wind Speed" => :wind_speed,
    "Wind Direction" => :wind_direction,
    "Pressure" => :pressure,
    "Visibility" => :visibility,
    "UV Index" => :uv_index,
    "Heat Index" => :heat_index,
    "Cloud Cover" => :cloud_cover,
    "Gust Speed" => :gust_speed,
    "Humidity" => :humidity,
    "Precipitation" => :precipitation,
    "Updated" => :fetched_at,
    "Cached" => :cached_at
  }.freeze

  def initialize(forecast)
    @forecast = forecast
    @units = forecast.units || Settings.default_units
  end

  def fields
    @fields ||= FIELDS.each_with_object({}) do |(label, field), result|
      value = forecast.send(field)
      if value.present?
        result[label] = value.to_s + field_symbol(field)
      end
    end
  end
end
