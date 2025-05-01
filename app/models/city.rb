class City < ApplicationRecord
  has_many :forecasts, dependent: :destroy

  validates :name, presence: true
  validates :region, presence: true

  def self.import
    Settings.countries.each do |country|
      states = CS.states(country[:code])
      states.each do |state_code, state_name|
        cities = CS.cities(state_code, country[:code])
        cities.each do |city_name|
          city = City.find_or_create_by!(
            country: country[:name],
            region: state_name,
            name: city_name)
          puts city.inspect
        end
      end
    end
  end
end
