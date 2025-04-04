class PagesController < ApplicationController
  # This controller handles static pages and the about page.
  # It provides methods to render the home page and the about page.
  # @note The home page displays the weather forecast, while the about page provides information about the application.
  def about
    @description = [
      "iWeather is a simple weather application that provides current weather information and forecasts for any location.",
      "It is built using Ruby on Rails and utilizes various modern web technologies to deliver a seamless user experience."
    ]
    @website = "https://github.com/dalezak/i-weather"
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
end
