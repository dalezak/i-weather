class PagesController < ApplicationController

  # This controller handles static pages and the about page.
  # It provides methods to render the home page and the about page.
  # @note The home page displays the weather forecast, while the about page provides information about the application.
  def about
    @features = {
      "Rails" => "Built using the latest version of Rails.",
      "Hotwire" => "Forecast displayed using Hotwire's turbo-frames.",
      "Stimulus" => "Geocoder location detection using Stimulus.",
      "Bootstrap Design" => "Responsive design using Bootstrap.",
      "Geolocation" => "Address lookup using Geocoder.",
      "Weather API" => "Weather data from Weather API.",
      "Measurements" => "Supports both metric and imperial units.",
      "Cookies" => "Cookies for storing user preferences.",
      "Service Objects" => "Service objects for business logic.",
      "View Partials" => "Reusable partials for views.",
      "View Helpers" => "Resuable view helpers for common tasks.",
      "Credentials" => "Rails credentials for sensitive data.",
      "Routes" => "Routes defined using resources convention.",
      "Tests" => "Controller, model, and system tests in Minitest.",
      "Source Code" => "Source code available on GitHub.",
      "MIT License" => "Open source under the MIT license.",
    }
  end

end
