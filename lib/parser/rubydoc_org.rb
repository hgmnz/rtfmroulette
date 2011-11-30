require_relative 'default'
module Parser
  class RubydocOrg < Default
    def extract_readable_doc
      Nokogiri::HTML(@raw_content).css('#documentation').tap do |doc|
        doc.css(".method-click-advice, .method-source-code").each { |node| node.remove }
      end
    end
  end
end
