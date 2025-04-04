class WeatherApiParser < ApplicationParser

  attr_reader :response, :unit

  # Initialize with response and unit
  # @param [Hash] response
  # @param [String] unit
  # @return [Forecast]
  def initialize(response, unit)
    @response = response
    @unit = unit.to_sym
  end

  def parse
    Forecast.new(
      updated_at: updated_at,
      cached_at: cached_at,
      location_name: location_name,
      location_region: location_region,
      location_country: location_country,
      icon: icon,
      condition: condition,
      temperature: temperature,
      feels_like: feels_like,
      wind_speed: wind_speed,
      wind_direction: wind_direction,
      pressure: pressure,
      visibility: visibility,
      uv_index: uv_index,
      heat_index: heat_index,
      dew_point: dew_point,
      cloud_cover: cloud_cover,
      gust_speed: gust_speed,
      humidity: humidity,
      precipitation: precipitation
    )
  end

  private
  
  def updated_at
    response.dig(:current, :last_updated)
  end

  def cached_at
    Time.current
  end

  def location_name
    response.dig(:location, :name)
  end

  def location_region
    response.dig(:location, :region)
  end

  def location_country
    response.dig(:location, :country)
  end

  def icon
    response.dig(:current, :condition, :icon)
  end

  def condition
    response.dig(:current, :condition, :text)
  end

  def temperature
    response.dig(:current, metric? ? :temp_c : :temp_f).to_s + symbol_for_field(:temperature)
  end

  def feels_like
    response.dig(:current, metric? ? :feelslike_c : :feelslike_f).to_s + symbol_for_field(:feels_like)
  end

  def wind_speed
    response.dig(:current, metric? ? :wind_kph : :wind_mph).to_s + symbol_for_field(:wind)
  end

  def wind_direction
    response.dig(:current, :wind_degree).to_s + symbol_for_field(:wind_degree)
  end

  def pressure
    response.dig(:current, metric? ? :pressure_mb : :pressure_in).to_s + symbol_for_field(:pressure)
  end

  def visibility
    response.dig(:current, metric? ? :vis_km : :vis_miles).to_s + symbol_for_field(:visibility)
  end

  def uv_index
    response.dig(:current, :uv).to_s
  end

  def heat_index
    response.dig(:current, metric? ? :heatindex_c : :heatindex_f).to_s + symbol_for_field(:heat_index)
  end

  def dew_point
    response.dig(:current, metric? ? :dewpoint_c : :dewpoint_f).to_s + symbol_for_field(:dew_point)
  end

  def cloud_cover
    response.dig(:current, :cloud).to_s + symbol_for_field(:cloud_cover)
  end

  def gust_speed
    response.dig(:current, metric? ? :gust_kph : :gust_mph).to_s + symbol_for_field(:gust_speed)
  end

  def humidity
    response.dig(:current, :humidity).to_s + symbol_for_field(:humidity)
  end

  def precipitation
    response.dig(:current, metric? ? :precip_mm : :precip_in).to_s + symbol_for_field(:precipitation)
  end

  def metric?
    unit == Rails.configuration.x.units[:metric][:unit]
  end

  def symbol_for_field(field)
    Rails.configuration.x.units[unit][field]
  end
  
end