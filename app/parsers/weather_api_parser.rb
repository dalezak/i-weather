class WeatherApiParser < ApplicationParser

  DEGREES = "°".freeze
  CELSIUS = "°C".freeze
  FAHRENHEIT = "°F".freeze
  KILOMETERS = "km".freeze
  KILOMETERS_PER_HOUR = "kph".freeze
  MILES = "mi".freeze
  MILES_PER_HOUR = "mph".freeze
  PERCENTAGE = "%".freeze
  INCHES = "in".freeze
  MILLIMETERS = "mm".freeze
  MILLIBARS = "mb".freeze

  attr_reader :response, :metric

  def initialize(response, metric)
    @response = response
    @metric = metric
  end

  def parse
    Forecast.new(
      updated_at: updated_at,
      cached_at: cached_at,
      metric: metric?,
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
    nil
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
    if metric?
      response.dig(:current, :temp_c).to_s + CELSIUS
    else
      response.dig(:current, :temp_f).to_s + FAHRENHEIT
    end
  end

  def feels_like
    if metric?
      response.dig(:current, :feelslike_c).to_s + CELSIUS
    else
      response.dig(:current, :feelslike_f).to_s + FAHRENHEIT
    end
  end

  def wind_speed
    if metric?
      response.dig(:current, :wind_kph).to_s + KILOMETERS_PER_HOUR
    else
      response.dig(:current, :wind_mph).to_s + MILES_PER_HOUR
    end
  end

  def wind_direction
    response.dig(:current, :wind_degree).to_s + DEGREES
  end

  def pressure
    if metric?
      response.dig(:current, :pressure_mb).to_s + MILLIBARS
    else
      response.dig(:current, :pressure_in).to_s + INCHES
    end
  end

  def visibility
    if metric?
      response.dig(:current, :vis_km).to_s + KILOMETERS
    else
      response.dig(:current, :vis_miles).to_s + MILES
    end
  end

  def uv_index
    response.dig(:current, :uv).to_s
  end

  def heat_index
    if metric?
      response.dig(:current, :heatindex_c).to_s + CELSIUS
    else
      response.dig(:current, :heatindex_f).to_s + FAHRENHEIT
    end
  end

  def dew_point
    if metric?
      response.dig(:current, :dewpoint_c).to_s + CELSIUS
    else
      response.dig(:current, :dewpoint_f).to_s + FAHRENHEIT
    end
  end

  def cloud_cover
    response.dig(:current, :cloud).to_s + PERCENTAGE
  end

  def gust_speed
    if metric?
      response.dig(:current, :gust_kph).to_s + KILOMETERS_PER_HOUR
    else
      response.dig(:current, :gust_mph).to_s + MILES_PER_HOUR
    end
  end

  def humidity
    response.dig(:current, :humidity).to_s + PERCENTAGE
  end

  def precipitation
    if metric?
      response.dig(:current, :precip_mm).to_s + MILLIMETERS
    else
      response.dig(:current, :precip_in).to_s + INCHES
    end
  end

  def metric?
    @metric
  end
  
end