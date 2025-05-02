# frozen_string_literal: true

# This class is responsible for parsing the data from the Weather API
class WeatherApi::Parser < ApplicationParser
  attr_reader :data, :units

  # Initialize with data and units
  # @param [Hash] data
  # @param [String] units
  # @return [Forecast]
  def initialize(data, units)
    @data = data
    @units = units
  end

  # Parse the data and return a Forecast object
  # @return [Forecast] Returns a Forecast object with the parsed data
  def parse
    return nil if data.blank?
    return nil if units.blank?
    return nil unless %w[metric imperial].include?(units)

    {
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
      precipitation: precipitation,
      fetched_at: last_updated,
      days: days
    }
  end

  private

  def last_updated
    data.dig(:current, :last_updated)
  end

  def icon
    data.dig(:current, :condition, :icon)
  end

  def condition
    data.dig(:current, :condition, :text)
  end

  def temperature
    data.dig(:current, metric? ? :temp_c : :temp_f)
  end

  def feels_like
    data.dig(:current, metric? ? :feelslike_c : :feelslike_f)
  end

  def wind_speed
    data.dig(:current, metric? ? :wind_kph : :wind_mph)
  end

  def wind_direction
    data.dig(:current, :wind_dir)
  end

  def pressure
    data.dig(:current, metric? ? :pressure_mb : :pressure_in)
  end

  def visibility
    data.dig(:current, metric? ? :vis_km : :vis_miles)
  end

  def uv_index
    data.dig(:current, :uv)
  end

  def heat_index
    data.dig(:current, metric? ? :heatindex_c : :heatindex_f)
  end

  def dew_point
    data.dig(:current, metric? ? :dewpoint_c : :dewpoint_f)
  end

  def cloud_cover
    data.dig(:current, :cloud)
  end

  def gust_speed
    data.dig(:current, metric? ? :gust_kph : :gust_mph)
  end

  def humidity
    data.dig(:current, :humidity)
  end

  def precipitation
    data.dig(:current, metric? ? :precip_mm : :precip_in)
  end

  def days
    forecast_days = data.dig(:forecast, :forecastday)
    return [] if forecast_days.blank?

    forecast_days.map do |day|
      {
        date: day.dig(:date),
        icon: day.dig(:day, :condition, :icon),
        condition: day.dig(:day, :condition, :text),
        max_temp: day.dig(:day, metric? ? :maxtemp_c : :maxtemp_f),
        min_temp: day.dig(:day, metric? ? :mintemp_c : :mintemp_f),
        max_wind: day.dig(:day, metric? ? :maxwind_kph : :maxwind_mph),
        avg_humidity: day.dig(:day, :avghumidity),
        avg_temp: day.dig(:day, metric? ? :avgtemp_c : :avgtemp_f),
        avg_visibility: day.dig(:day, metric? ? :avgvis_km : :avgvis_miles),
        total_precipitation: day.dig(:day, metric? ? :totalprecip_mm : :totalprecip_in)
    }
    end
  end

  def metric?
    units == Settings.metric_name
  end
end
