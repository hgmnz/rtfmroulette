require 'open-uri'
require 'uri'
require 'nokogiri'

class Crawler
  MAX_DEPTH = 5.freeze

  def self.run
    Root.all.each do |root|
      new(root.url, root).crawl
    end
  end

  def initialize(url, root, depth = 1)
    @url   = url
    @root  = root
    @depth = depth
  end

  def crawl
    unless source_exists?
      store_content
    end
    crawl_links
  end

  def content
    @content ||= open(@url).read rescue ''
  end

  def crawl_links
    if @depth < MAX_DEPTH
      links.each do |link|
        next unless link['href']
        next if %w(/ #).include? link['href'].strip
        absolute_url = (uri + link['href'].strip).to_s
        next unless absolute_url =~ /#{@root.crawl_scope}/
        Crawler.new(absolute_url, @root, @depth + 1).crawl
      end
    end
  end

  def links
    doc.xpath('//a')
  end

  def title
    doc.at('//title').text
  end

  def store_content
    Source.create(content: content, url: @url, root_id: @root.id, title: title)
  end

  def uri
    URI.parse(@url)
  end

  def source_exists?
    Source.where(url: @url).count > 0
  end

  def doc
    @doc ||= Nokogiri::HTML(content)
  end
end
