require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit pages_url
    fill_in :location, with: "Saskatoon, Saskatchewan"
    click_on :search
    wait_for_turbo_frame
    assert_selector "h6", text: "Current"
    assert_selector "h6", text: "Condition"
    assert_selector "h6", text: "Temperature"
  end
end
