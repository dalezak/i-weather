# frozen_string_literal: true

# This class is responsible for parsing the data from the Weather API
class WeatherStack::Parser < ApplicationParser
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
      cloud_cover: cloud_cover,
      humidity: humidity,
      precipitation: precipitation,
      fetched_at: data.dig(:current, :observation_time),
      days: []
    }
  end

  private

  def icon
    data.dig(:current, :weather_icons)&.first
  end

  def condition
    data.dig(:current, :weather_descriptions)&.first
  end

  def temperature
    data.dig(:current, :temperature)
  end

  def feels_like
    data.dig(:current, :feelslike)
  end

  def wind_speed
    data.dig(:current, :wind_speed)
  end

  def wind_degree
    data.dig(:current, :wind_degree)
  end

  def wind_direction
    data.dig(:current, :wind_dir)
  end

  def pressure
    data.dig(:current, :pressure)
  end

  def visibility
    data.dig(:current, :visibility)
  end

  def uv_index
    data.dig(:current, :uv_index)
  end

  def cloud_cover
    data.dig(:current, :cloudcover)
  end

  def humidity
    data.dig(:current, :humidity)
  end

  def precipitation
    data.dig(:current, :precip)
  end
end
