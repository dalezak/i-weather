class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # The user's current units, either metric or imperial.
  # @return [String] the current units, either 'metric' or 'imperial'.
  # @note Defaults to the value set in the Rails configuration.
  # @see Rails.configuration.x.default_units
  # @see Rails.configuration.x.units
  def current_units
    @current_units ||= cookies[:units] || Rails.configuration.x.default_units
  end

  # Is the current units metric?
  # @return [Boolean] true if the current units are metric, false otherwise.
  # @see Rails.configuration.x.units
  # @see #current_units
  # @example
  #   if metric?
  #     # Do something for metric units
  #   else
  #     # Do something for imperial units
  #   end
  # @note This method checks the current units against the metric units defined in the Rails configuration.
  def metric?
    current_units == Rails.configuration.x.units[:metric][:name]
  end

  # Is the current units imperial?
  # @return [Boolean] true if the current units are imperial, false otherwise.
  # @see Rails.configuration.x.units
  # @see #current_units
  # @example
  #   if imperial?
  #     # Do something for imperial units
  #   else
  #     # Do something for metric units
  #   end
  # @note This method checks the current units against the imperial units defined in the Rails configuration.
  def imperial?
    current_units == Rails.configuration.x.units[:imperial][:name]
  end

  # Set the current units in the cookies.
  # @param units [String] the units to set, either 'metric' or 'imperial'.
  # @note This method sets the units in the cookies for persistence across requests.
  def set_units(units)
    @current_units = cookies[:units] = units
  end

  # Set the current units to metric.
  # @note This method sets the units to metric in the cookies for persistence across requests.
  def set_units_metric
    set_units(Rails.configuration.x.units[:metric][:name])
  end

  # Set the current units to imperial.
  # @note This method sets the units to imperial in the cookies for persistence across requests.
  def set_units_imperial
    set_units(Rails.configuration.x.units[:imperial][:name])
  end
end
