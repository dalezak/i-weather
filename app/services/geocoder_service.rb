class GeocoderService < ApplicationService
  attr_reader :latitude, :longitude

  # Initialize with latitude and longitude
  # @param [Float] latitude
  # @param [Float] longitude
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def call
    geocode = Geocoder.search([latitude, longitude]).first
    if geocode.present? && geocode.city.present? && geocode.state.present?
      [geocode.city, geocode.state].join(", ")
    else
      nil
    end
  end

end