require_relative 'default'
module Parser
  class RubydocOrg < Default
    def extract_readable_doc
      Nokogiri::HTML(@raw_content).css('#documentation')
    end
  end
end
