class UnitsController < ApplicationController
  
  # This controller handles the user's unit preference for displaying weather data.
  # It provides methods to set the units to metric or imperial.
  # @note The metric system uses Celsius, km/h, etc., while the imperial system uses Fahrenheit, mph, etc.
  
  # Sets the units to metric and displays a success message.
  # @note Redirects to the root path after setting the units.
  # @return [void]
  def metric
    set_units_metric
    flash[:notice] = "Your units have been set to metric, so you'll see celsius, km/h, etc"
    redirect_to root_path
  end

  # Sets the units to imperial and displays a success message.
  # @note Redirects to the root path after setting the units.
  # @return [void]
  # @note The imperial system uses Fahrenheit, mph, etc.
  # @return [void]
  def imperial
    set_units_imperial
    flash[:notice] = "Your units have been set to imperial, so you'll see fahrenheit, mph, etc"
    redirect_to root_path
  end
end
