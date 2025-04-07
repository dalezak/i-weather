require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  # This method is used to wait for a Turbo Frame to finish loading.
  # It checks if the frame is busy and waits for it to become not busy.
  # The selector should be a string representing the Turbo Frame's CSS selector.
  # The timeout parameter specifies how long to wait for the frame to finish loading.
  #
  # @param selector [String] The CSS selector for the Turbo Frame.
  # @param timeout [Integer] The maximum time to wait for the frame to finish loading.
  #
  # @return [void]
  def wait_for_turbo_frame(selector: "turbo-frame", timeout: 5.seconds)
    if has_selector?("#{selector}[busy]", visible: true, wait: 0.25.seconds)
      has_no_selector?("#{selector}[busy]", wait: timeout)
    end
  end
end
