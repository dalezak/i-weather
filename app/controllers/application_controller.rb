class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_units
    @current_units ||= cookies[:units] || Rails.configuration.x.default_units
  end

  def metric?
    current_units == Rails.configuration.x.units[:metric][:name]
  end
  
  def imperial?
    current_units == Rails.configuration.x.units[:imperial][:name]
  end

  def set_units(units)
    @current_units = cookies[:units] = units
  end

  def set_units_metric
    set_units(Rails.configuration.x.units[:metric][:name])
  end

  def set_units_imperial
    set_units(Rails.configuration.x.units[:imperial][:name])
  end

end
