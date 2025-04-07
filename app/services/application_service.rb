# This is a base class for all service objects in the application.
class ApplicationService
  # The `call` method is the main entry point for the service object.
  # It should be overridden in subclasses to implement the desired behavior.
  def call
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # This method allows you to call the service object directly without needing to create an instance first.
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
