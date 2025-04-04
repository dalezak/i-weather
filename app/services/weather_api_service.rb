class WeatherApiService < ApplicationService
  include HTTParty
  base_uri 'api.weatherapi.com/v1'
  format :json

  attr_accessor :query, :units, :options

  # Initialize with query and unit
  # @param [String] query
  # @param [String] units
  # @return [Forecast]
  def initialize(query, units)
    @query = query
    @units = units
    @options = { query: { key: api_key, aqi: "no", q: query } }
  end

  def call
    return nil if query.blank?
    return nil if units.blank?
    return nil unless %w[metric imperial].include?(units)

    Rails.cache.fetch(cache_key, expires_in: expires_in) do
      response = self.class.get("/v1/current.json", options)
      WeatherApiParser.parse(response.parsed_response.with_indifferent_access, units)
    end
  end

  private

  def api_key
    Rails.application.credentials.weather_api_key
  end

  def expires_in
    Rails.application.config.x.cache_expires_in || 30.minutes
  end

  def cache_key
    ["weather_api", units, query.parameterize].join("/")
  end

end