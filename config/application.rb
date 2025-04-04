require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IWeather
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.x.units = {
      metric: {
        name: "metric",
        label: "Celsius °C",
        temperature: "°C",
        wind: "km/h",
        pressure: "mb",
        humidity: "%",
        visibility: "km",
        precipitation: "mm",
        uv_index: "UV",
        dew_point: "°C",
        feels_like: "°C",
        wind_degree: "°",
        wind_speed: "km/h",
        wind_direction: "°",
        gust_speed: "km/h",
        cloud_cover: "%",
        heat_index: "°C"
      },
      imperial: {
        name: "imperial",  
        label: "Fahrenheit °F",
        temperature: "°F",
        wind: "mph",
        pressure: "in",
        humidity: "%",
        visibility: "mi",
        precipitation: "in",
        uv_index: "UV",
        dew_point: "°F",
        feels_like: "°F",
        wind_degree: "°",
        wind_speed: "mph",
        wind_direction: "°",
        gust_speed: "mph",
        cloud_cover: "%",
        heat_index: "°F"
      }
    }
    config.x.default_units = :metric
  end
end
