require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get about page" do
    get about_pages_url
    assert_response :success
  end

  test "missing page should redirect to root" do
    get "/nonexistent_page"
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end
end
