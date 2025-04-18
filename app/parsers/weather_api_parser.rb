# frozen_string_literal: true

# This class is responsible for parsing the response from the Weather API
class WeatherApiParser < ApplicationParser
  attr_reader :response, :units

  # Initialize with response and units
  # @param [Hash] response
  # @param [String] units
  # @return [Forecast]
  def initialize(response, units)
    @response = response
    @units = units
  end

  # Parse the response and return a Forecast object
  # @return [Forecast] Returns a Forecast object with the parsed data
  def parse
    return Forecast.new if response.blank?
    return Forecast.new if units.blank?
    return Forecast.new unless %w[metric imperial].include?(units)

    Forecast.new(
      updated_at: updated_at,
      cached_at: cached_at,
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
      days: days
    )
  end

  private

  def updated_at
    response.dig(:current, :last_updated)
  end

  def cached_at
    Time.current
  end

  def icon
    response.dig(:current, :condition, :icon)
  end

  def condition
    response.dig(:current, :condition, :text)
  end

  def temperature
    response.dig(:current, metric? ? :temp_c : :temp_f).to_s + field_symbol(:temperature)
  end

  def feels_like
    response.dig(:current, metric? ? :feelslike_c : :feelslike_f).to_s + field_symbol(:feels_like)
  end

  def wind_speed
    response.dig(:current, metric? ? :wind_kph : :wind_mph).to_s + field_symbol(:wind)
  end

  def wind_direction
    response.dig(:current, :wind_degree).to_s + field_symbol(:wind_degree)
  end

  def pressure
    response.dig(:current, metric? ? :pressure_mb : :pressure_in).to_s + field_symbol(:pressure)
  end

  def visibility
    response.dig(:current, metric? ? :vis_km : :vis_miles).to_s + field_symbol(:visibility)
  end

  def uv_index
    response.dig(:current, :uv).to_s
  end

  def heat_index
    response.dig(:current, metric? ? :heatindex_c : :heatindex_f).to_s + field_symbol(:heat_index)
  end

  def dew_point
    response.dig(:current, metric? ? :dewpoint_c : :dewpoint_f).to_s + field_symbol(:dew_point)
  end

  def cloud_cover
    response.dig(:current, :cloud).to_s + field_symbol(:cloud_cover)
  end

  def gust_speed
    response.dig(:current, metric? ? :gust_kph : :gust_mph).to_s + field_symbol(:gust_speed)
  end

  def humidity
    response.dig(:current, :humidity).to_s + field_symbol(:humidity)
  end

  def precipitation
    response.dig(:current, metric? ? :precip_mm : :precip_in).to_s + field_symbol(:precipitation)
  end

  def days
    forecast_days = response.dig(:forecast, :forecastday)
    return [] if forecast_days.blank?

    forecast_days.map do |day|
      Day.new(
        date: day.dig(:date),
        max_temp: day.dig(:day, metric? ? :maxtemp_c : :maxtemp_f).to_s + field_symbol(:temperature),
        min_temp: day.dig(:day, metric? ? :mintemp_c : :mintemp_f).to_s + field_symbol(:temperature),
        condition: day.dig(:day, :condition, :text),
        icon: day.dig(:day, :condition, :icon)
      )
    end
  end

  def metric?
    units == Settings.metric_name
  end

  def field_symbol(field)
    Settings.units_field_symbol(units, field)
  end
end
