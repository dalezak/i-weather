class ApplicationPresenter
  # Obtain the units symbol for a given field.
  # @param field [Symbol] the field for which to obtain the units symbol.
  # @return [String] the units symbol for the specified field.
  # @note This method uses the Settings class to retrieve the units symbol based on the current units and field.
  # @example
  #   field_symbol(:temperature) # => "°C" or "°F"
  def field_symbol(field)
    Settings.units_field_symbol(units, field)
  end
end
