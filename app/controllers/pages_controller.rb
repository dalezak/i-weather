# frozen_string_literal: true

# This controller handles the main pages of the application, including the home page and the about page.
# It also manages the weather forecast functionality, allowing users to view weather information for different locations.

class PagesController < ApplicationController
  before_action :load_location, only: [ :index, :forecast ]
  before_action :load_city, only: [ :index, :forecast ]
  before_action :load_forecast, only: [ :index, :forecast ]

  # The home page provides a form for users to enter their location and view the weather forecast.
  # @note The forecast results are displayed using Turbo frames for a seamless experience.
  # @note The page also handles geolocation detection using Stimulus.
  def index
  end

  # The about provides information about the application, its features, and the technologies used.
  # @note The about page includes a description, website link, and a list of features.
  def about
    @features = {
      "Rails" => "Built using the latest version of Rails.",
      "Hotwire" => "Forecast displayed using Hotwire's turbo-frames.",
      "Stimulus" => "Geocoder location detection using Stimulus.",
      "Bootstrap" => "Responsive design using Bootstrap.",
      "Geolocation" => "Address lookup using Geocoder.",
      "APIs" => "Weather data from Weather API.",
      "Measurements" => "Supports both metric and imperial units.",
      "Cookies" => "Cookies for storing user preferences.",
      "Caching" => "Forecast caching for performance.",
      "Service Objects" => "Service objects for business logic.",
      "View Partials" => "Reusable partials for views.",
      "View Helpers" => "Resuable view helpers for common tasks.",
      "Credentials" => "Rails credentials for sensitive data.",
      "Routes" => "Routes defined using resources convention.",
      "Tests" => "Controller, model, and system tests in Minitest.",
      "Code Comments" => "Code is well-commented for clarity.",
      "Source Code" => "Source code available on GitHub.",
      "MIT License" => "Open source under the MIT license."
    }
  end

  # This action is used to display the weather forecast for a specific location.
  # It sets the location based on parameters or cookies and loads the forecast data.
  # @note The forecast page provides detailed weather information for the specified location.
  def forecast
  end

  # Sets the units to metric and displays a success message.
  # @note Redirects to the root path after setting the units.
  def metric
    set_units_metric
    flash[:notice] = "Your units have been set to metric, so you'll see Celsius°, km/h, etc"
    redirect_to root_path
  end

  # Sets the units to imperial and displays a success message.
  # @note Redirects to the root path after setting the units.
  def imperial
    set_units_imperial
    flash[:notice] = "Your units have been set to imperial, so you'll see Fahrenheit°, mph, etc"
    redirect_to root_path
  end

  private

  # Sets the location based on parameters or cookies.
  # @note This method checks for latitude and longitude parameters, a location parameter, or a location stored in cookies.
  def load_location
    if params[:latitude].present? && params[:longitude].present?
      latitude = params[:latitude].to_f
      longitude = params[:longitude].to_f
      @location = cookies[:location] = GeoLocation::Service.new(latitude, longitude).call
    elsif params[:location].present?
      @location = cookies[:location] = params[:location]
    elsif cookies[:location].present?
      @location = cookies[:location]
    else
      @location = nil
    end
  end

  # Loads the city based on the location string.
  # @note This method splits the location string into city and region components.
  # It uses the city name and region to find or create a city record in the database.
  # @return [City, nil] Returns the city object or nil if no location is specified.
  # @note The city is created if it does not exist in the database.
  # @note The city name and region are stripped of leading and trailing whitespace.
  def load_city
    if @location.present? && @location.include?(",")
      name, region = @location.split(",").map(&:strip)
      @city = City.find_or_create_by(name: name, region: region)
    else
      @city = nil
    end
  end

  # Loads the forecast data for the specified city.
  # @note This method checks if the city is present and retrieves the forecast data from the database.
  # If the forecast data is stale, it refreshes the data from the weather API.
  # @return [Forecast, nil] Returns the forecast object or nil if no city is specified.
  # @note The forecast data is cached for performance.
  def load_forecast
    if @city.present?
      @forecast = Forecast.find_or_create_by(city: @city, units: current_units)
      @forecast.refresh! if @forecast.refresh?
    else
      @forecast = nil
    end
  end
end
