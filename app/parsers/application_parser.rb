class ApplicationParser
  def self.parse(*args, &block)
    new(*args, &block).parse
  end
end
