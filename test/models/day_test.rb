require "test_helper"

class DayTest < ActiveSupport::TestCase
  test "valid? is false" do
    day = Day.new
    assert_not day.valid?
  end

  test "valid? is true" do
    day = Day.new(date: Date.today.to_s)
    assert day.valid?
  end
end
