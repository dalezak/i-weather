class Settings
  class << self
    # The Weather API key
    # @return [String, nil] The Weather API key or nil if not found
    def weather_api_key
      credentials(:weather_api_key)
    end

    # The cache expires_in time
    # @return [Integer] The cache expiration timexw
    def cache_expires_in
      configuration(:cache_expires_in)
    end

    # The default units for the application
    # @return [String] The default units, either 'metric' or 'imperial'
    # @note This value is set in the Rails configuration
    def default_units
      configuration(:default_units)
    end

    # The units configuration
    # @return [Hash] The units configuration hash
    # @note This value is set in the Rails configuration
    def units
      configuration(:units)
    end

    # Returns name for metric units
    # @return [String] The name for metric units
    def metric_name
      units.dig(:metric, :name)
    end

    # Returns name for imperial units
    # @return [String] The name for imperial units
    def imperial_name
      units.dig(:imperial, :name)
    end

    # Returns the metric unit symbol
    # @return [Symbol] The symbol for metric units
    def metric_sym
      metric_name.to_sym
    end

    # Returns the imperial unit symbol
    # @return [Symbol] The symbol for imperial units
    def imperial_sym
      imperial_name.to_sym
    end

    # Returns the metric unit label
    # @return [String] The label for metric units
    def metric_label
      units.dig(:metric, :label)
    end

    # Returns the imperial unit label
    # @return [String] The label for imperial units
    def imperial_label
      units.dig(:imperial, :label)
    end

    # Returns the unit symbol for a given unit and field
    # @param unit [Symbol] The unit symbol, either :metric or :imperial
    # @param field [Symbol] The field symbol, e.g., :temperature, :humidity
    # @return [String] The unit symbol for the given unit and field
    # @note This method fetches the unit symbol from the units configuration hash
    def units_field_symbol(unit, field)
      units.dig(unit, field)
    end

    private

    # Fetch value from Rails credentials
    # @param key [Symbol] The key to fetch from credentials
    # @return [String, nil] The value from credentials or nil if not found
    def credentials(key)
      Rails.application.credentials[key]
    end

    # Fetch value from Rails configuration
    # @param key [Symbol] The key to fetch from configuration
    # @return [String, nil] The value from configuration or nil if not found
    def configuration(key)
      Rails.application.config.x.public_send(key)
    end
  end
end
