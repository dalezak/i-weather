require "application_system_test_case"

class ForecastsTest < ApplicationSystemTestCase
  test "visiting the index" do
    puts "Visiting the index"
    visit forecasts_url
    fill_in :location, with: "Saskatoon"
    click_on :search
  end
end
