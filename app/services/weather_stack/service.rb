# frozen_string_literal: true

# This class is responsible for fetching weather data from the Weather API
class WeatherStack::Service < ApplicationService
  include HTTParty
  base_uri "api.weatherstack.com"
  format :json

  attr_accessor :city, :region, :units, :days, :options

  # Initialize with city, region and days
  # @param [String] city
  # @param [String] region
  # @param [String] days
  # @return [Hash]
  def initialize(city, region, units, days = 4)
    @city = city
    @region = region
    @units = units
    @days = days
    @options = { query: { access_key: api_key, query: [ city, region ].compact.join(", "), forecast_days: days, hourly: 0 } }
  end

  # Fetch weather data from the API
  # @return [Forecast, nil] Returns a Forecast object or nil if the location is blank or units are invalid
  def call
    return nil if options.blank?

    Rails.cache.fetch(cache_key, expires_in: expires_in) do
      response = self.class.get("/current", options)
      data = response.parsed_response.with_indifferent_access
      WeatherStack::Parser.parse(data, units)
    end
  end

  private

  # The Weather API key from Rails configuration
  # @return [String] The API key for the weather API
  def api_key
    Settings.weather_stack_key
  end

  # Fetch the cache expiration time from Rails configuration
  # @return [Integer] The cache expiration time in seconds
  def expires_in
    Settings.cache_expires_in
  end

  # Generate a cache key based on the API name, units, and location
  # @return [String] The cache key for the weather API
  def cache_key
    [ "weather_stack", units.to_s.parameterize, region.to_s.parameterize, city.to_s.parameterize, days ].compact.join("/")
  end
end
