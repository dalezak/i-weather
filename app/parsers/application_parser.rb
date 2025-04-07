# This is a base class for parsers that can be used to parse various types of data.
class ApplicationParser
  # The `parse` method is the main entry point for the parser.
  # It should be overridden in subclasses to implement the desired parsing behavior.
  def parse
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # This method allows you to call the parser directly without needing to create an instance first.
  def self.parse(*args, &block)
    new(*args, &block).parse
  end
end
