class PagesController < ApplicationController

  def about
    @features = {
      "Rails" => "Built using the latest version of Rails.",
      "Hotwire" => "Forecast displayed using Hotwire's turbo-frames.",
      "Stimulus" => "Geocoder location detection using Stimulus.",
      "Bootstrap Design" => "Responsive design using Bootstrap.",
      "Location Detection" => "Geolocation detection using Geocoder.",
      "Weather API" => "Weather data from Weather API.",
      "Cookies" => "Cookies for storing user preferences.",
      "Service Objects" => "Service objects for business logic.",
      "View Partials" => "Reusable partials for views.",
      "View Helpers" => "Resuable view helpers for common tasks.",
      "Credentials" => "Rails credentials for sensitive data.",
      "Routes" => "RESTful routes for resources.",
      "Tests" => "Controller, model, and system tests in Minitest.",
      "Source Code" => "Source code available on GitHub.",
      "MIT License" => "Open source under the MIT license.",
    }
  end

end
