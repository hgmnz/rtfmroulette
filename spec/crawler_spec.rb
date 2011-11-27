require_relative 'spec_helper'

shared_context 'crawl specs' do
  let(:root) { FactoryGirl.build(:root) }
  let(:url)  { 'http://rtfmroulette.com/something/else/here' }
end

describe Crawler, '#crawl' do
  it 'does not store the content if the source exists' do
    source = FactoryGirl.create(:source, url: url)

    crawler = Crawler.new(url, root, 1)

    crawler.should_not_receive(:store_content)
    crawler.should_receive(:crawl_links).once
    crawler.crawl
  end

  it 'stores when it has not been stored before' do
    crawler = Crawler.new(url, root, 1)

    crawler.should_receive(:store_content).once
    crawler.should_receive(:crawl_links).once
    crawler.crawl
  end

  include_context 'crawl specs'
end

describe Crawler, '#links' do
  it 'finds all links in the page content' do
    crawler = Crawler.new(url, root, 1)
    crawler.stub(:doc => Nokogiri::HTML(<<-END))
    <div>not a link</div>
    <a href="foo">foo</a>
    </div> another div</div>
    <a href="bar">bar</a>
    END

    crawler.links.map { |l| l['href'] }.should =~ %w(foo bar)
  end

  include_context 'crawl specs'
end

describe Crawler, '#title' do
  it 'finds the title' do
    crawler = Crawler.new(url, root, 1)
    crawler.stub(:doc => Nokogiri::HTML(<<-END))
    <title>I am the title</title>
    <body>Something here</body>
    END

    crawler.title.should == 'I am the title'
  end
  include_context 'crawl specs'
end
