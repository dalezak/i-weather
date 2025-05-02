# This is a base class for all service objects in the application.
class ApplicationService
  # The `call` method is the main entry point for the service object.
  # It should be overridden in subclasses to implement the desired behavior.
  def call
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # This method allows you to call the service object directly without needing to create an instance first.
  def self.call(*args, &block)
    new(*args.first, &block).call
  end

  # This method generates a cache key based on the provided arguments.
  # It converts each argument to a string, parameterizes it, and joins them with slashes.
  # @param [Array] args The arguments to generate the cache key from.
  def get_cache_key(*args)
    args.compact.map(&:to_s).map(&:parameterize).join("/")
  end
end
