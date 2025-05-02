class City < ApplicationRecord
  has_many :forecasts, dependent: :destroy

  validates :name, presence: true
  validates :region, presence: true

  # This method imports cities from the CS gem based on the countries defined in the Settings.
  # It iterates through each country, retrieves the states and cities, and creates city records in the database.
  def self.import
    Settings.countries.each do |country|
      states = CS.states(country[:code])
      states.each do |state_code, state_name|
        cities = CS.cities(state_code, country[:code])
        cities.each do |city_name|
          city = City.find_or_create_by!(
            region: state_name,
            name: city_name)
          puts city.inspect
        end
      end
    end
  end
end
