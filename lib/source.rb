class Source < Sequel::Model
  def readable_content
    Readability::Document.new(content, retry_length: 10).content
  end

  def self.random
    Source.limit(1, rand(Source.count)).first
  end
end
