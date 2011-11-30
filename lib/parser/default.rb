module Parser
  class Default

    def initialize(source)
      @raw_content  = source.content
      @url          = source.url
      @readable_doc = extract_readable_doc
    end

    def readable_content
      convert_links_to_absolute
      add_prettyprint_classes
      @readable_doc.to_html
    end

    def extract_readable_doc
      Nokogiri::HTML(Readability::Document.new(@raw_content, retry_length: 10).content)
    end

    protected
    def convert_links_to_absolute
      @readable_doc.css('a').each do |link|
        if link['href']
          begin
            absolute = (self.uri + link['href']).to_s
            link['href'] = absolute
          rescue URI::InvalidURIError
            link['href'] = ''
          end
        end
      end
    end

    def add_prettyprint_classes
      @readable_doc.css('pre').each do |pre|
        pre['class'] = 'prettyprint'
      end
    end

    def uri
      URI.parse(@url)
    end
  end
end
