class Source < Sequel::Model
  many_to_one :root

  def readable_content
    Parser::Default.new(self).readable_content
  end

  def self.random
    Source.limit(1, rand(Source.count)).first
  end

  def upvote
    set(upvotes: upvotes + 1).save
  end

  def downvote
    set(downvotes: downvotes + 1).save
  end

  def topic
    root.topic
  end

  def host
    uri.host
  end

  def uri
    URI.parse(url)
  end

  def parser

  end
end
