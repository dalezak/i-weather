class WeatherApiService < ApplicationService
  include HTTParty
  base_uri 'api.weatherapi.com/v1'
  format :json

  attr_accessor :query, :unit, :options

  # Initialize with query and unit
  # @param [String] query
  # @param [String] unit
  # @return [Forecast]
  def initialize(query, unit)
    @query = query
    @unit = unit
    @options = { query: { key: key, aqi: "no", q: query } }
  end

  def call
    Rails.cache.fetch(cache_key, expires_in: 1.minutes) do
      response = self.class.get("/v1/current.json", options)
      WeatherApiParser.parse(response.parsed_response.with_indifferent_access, unit)
    end
  end

  private

  def key
    Rails.application.credentials.weather_api_key
  end

  def cache_key
    ["weather_api", unit, query.parameterize].join("/")
  end

end