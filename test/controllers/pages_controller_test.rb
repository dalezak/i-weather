require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get about_pages_url
    assert_response :success
  end
end
