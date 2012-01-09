class ParserFactory
  def initialize(source)
    @source = source
  end

  def self.create_parser(source)
    new(source).create
  end

  def create
    parser_class.new(@source)
  end

  def parser_class
    locate_parser || Parser::Default
  end

  def locate_parser
    class_name = @source.uri.host.
      gsub('-', '').
      split('.').
      map(&:classify).
      join('')
    "Parser::#{class_name}".constantize if Parser.const_defined?(class_name)
  end
end
