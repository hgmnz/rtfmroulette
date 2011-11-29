module Parser
  class Default

    def initialize(source)
      @raw_content = source.content
      @url         = source.url
    end

    def readable_content
      readable = Readability::Document.new(@raw_content, retry_length: 10).content
      doc = Nokogiri::HTML(readable)
      doc.css('a').each do |link|
        if link['href']
          absolute = (self.uri + link['href']).to_s
          link['href'] = absolute
        end
      end
      doc.to_html
    end

    def uri
      URI.parse(@url)
    end
    protected :uri
  end
end
