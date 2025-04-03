class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_unit
    @current_unit ||= cookies[:unit] || Rails.configuration.x.default_units
  end

  def metric?
    current_unit == Rails.configuration.x.units[:metric][:unit]
  end
  
  def imperial?
    current_unit == Rails.configuration.x.units[:imperial][:unit]
  end

  def set_unit(unit)
    @current_unit = cookies[:unit] = unit
  end

  def set_metric
    set_unit(Rails.configuration.x.units[:metric][:unit])
  end

  def set_imperial
    set_unit(Rails.configuration.x.units[:imperial][:unit])
  end

end
