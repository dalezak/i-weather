require "test_helper"

class ApplicationHelpersTest < ActionView::TestCase
  include ApplicationHelper

  test "format_date returns nil for blank date" do
    assert_nil format_date(nil)
  end

  test "format_date returns formatted date for valid date" do
    date = Date.new(2025, 04, 4)
    assert_equal "Friday, April 4th", format_date(date)
  end

  test "day_suffix returns correct suffix for day" do
    assert_equal "st", day_suffix(1)

    assert_equal "th", day_suffix(4)

    assert_equal "nd", day_suffix(2)
    assert_equal "nd", day_suffix(22)

    assert_equal "rd", day_suffix(3)
    assert_equal "rd", day_suffix(23)

    assert_equal "st", day_suffix(21)
    assert_equal "st", day_suffix(31)
  end

  test "active_for_path returns 'active' for matching path" do
    params[:action] = "index"
    assert_equal "active", active_for_path("index")
  end

  test "active_for_path returns nil for non-matching path" do
    params[:action] = "about"
    assert_nil active_for_path("index")
  end
end
