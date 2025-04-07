module ApplicationHelper
  # Returns the page or site title
  # @return [String] the page or site title
  def page_title
    content_for(:title) || Settings.site_title
  end

  # Returns the page or site description
  # @return [String] the page or site description
  def page_description
    content_for(:description) || Settings.site_description
  end

  # Returns the page or site URL
  # @return [String] the page or site URL
  def page_url
    content_for(:url) || Settings.site_url
  end

  # Returns label for metric units
  # @return [String] the label for metric units
  def metric_label
    Settings.metric_label
  end

  # Returns label for imperial units
  # @return [String] the label for imperial units
  def imperial_label
    Settings.imperial_label
  end

  # Returns the appropriate class for flash messages
  # @param level [Symbol] the flash message level (e.g., :notice, :alert, :success)
  # @return [String] the CSS class for the flash message
  def flash_class(level)
    case level.to_sym
    when :notice
      "info"
    when :alert
      "danger"
    when :success
      "success"
    else
      "secondary"
    end
  end

  # Returns 'active' class if the current action matches the given path
  # @param path [String] the path to check against the current action
  # @return [String] 'active' if the current action matches the path, nil otherwise
  def active_for_path(path)
    "active" if params[:action] == path
  end

  # Returns the appropriate field value based on the label and value
  # @param label [String] the label of the field
  # @param value [String] the value of the field
  # @return [String] the formatted field value
  # @note If the value is blank, returns "n/a". If the label is 'Updated' or 'Cached', returns a time ago string.
  def field_value(label, value)
    if value.blank?
      content_tag(:p, class: "fs-5 my-2") do
        "n/a"
      end
    elsif label == "Current"
      image_tag(value, alt: "Weather Icon", class: "img-icon")
    elsif %w[Updated Cached].include?(label)
      content_tag(:p, class: "fs-5 my-2") do
        time_ago_in_words(value) + " ago"
      end
    else
      content_tag(:p, class: "fs-5 my-2") do
        value
      end
    end
  end

  # Returns the formatted date string
  # @param date [Date, Time] the date to format
  # @return [String] the formatted date string
  # @note If the date is blank, returns nil. The format is 'Day, Month Day' with a suffix for the day.
  def format_date(date)
    return if date.blank?

    date = date.to_date
    date.strftime("%A, %B %-d") + day_suffix(date.day)
  end

  # Returns the appropriate suffix for the day of the month
  # @param day [Integer] the day of the month
  # @return [String] the suffix for the day of the month
  # @note The suffixes are 'st', 'nd', 'rd', and 'th' based on the day of the month.
  def day_suffix(day)
    case day
    when 1, 21, 31
      "st"
    when 2, 22
      "nd"
    when 3, 23
      "rd"
    else
      "th"
    end
  end
end
