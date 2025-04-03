module ApplicationHelper

  UNITS = [
    METRIC = "metric".freeze,
    IMPERIAL = "imperial".freeze
  ].freeze

  def unit
    cookies[:unit] || METRIC
  end

  def metric?
    unit == METRIC
  end
  
  def imperial?
    unit == IMPERIAL
  end

  def flash_class(level)
    case level.to_sym
    when :notice
      return "info"
    when :alert
      return "danger"
    when :success
      return "success"
    else
      "secondary"
    end
  end

  def active_for_path(path)
    "active" if params[:action] == path
  end

end
