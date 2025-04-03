class WeatherApiService < ApplicationService
  include HTTParty
  base_uri 'api.weatherapi.com/v1'
  format :json

  def initialize(query, metric = true)
    @options = { query: { key: key, aqi: "no", q: query } }
    @metric = metric
  end

  def call
    response = self.class.get("/v1/current.json", @options)
    if response.success?
      WeatherApiParser.parse(response.parsed_response.with_indifferent_access, @metric)
    else
      nil
    end
  end

  private

  def key
    Rails.application.credentials.weather_api_key
  end

end