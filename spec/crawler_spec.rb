require_relative 'spec_helper'

shared_context 'crawl specs' do
  let(:root) { FactoryGirl.build(:root, url: 'http://rtfmroulette.com') }
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

describe Crawler, '#store_content' do
  it 'creates a source record' do
    root.save
    crawler = Crawler.new(url, root, 1)
    crawler.stub(title: "King of the jungle", content: "cats")
    crawler.store_content

    Source.where(url:     url,
                 title:   "King of the jungle",
                 content: "cats").
                 count.should be > 0
  end

  include_context 'crawl specs'
end

describe Crawler, '#craw_links' do
  it 'does not crawl if it has reached the max depth' do
    crawler = Crawler.new(url, root, Crawler::MAX_DEPTH)
    crawler.should_not_receive(:links)
    crawler.crawl_links
  end

  it 'creates a new crawler a level deeper for the links found' do
    crawler = Crawler.new(url, root, 1)
    crawler.stub(links: [{'href' => '/foo/bar'}])
    new_crawler = double('crawler', crawl: true)
    Crawler.should_receive(:new).
      with('http://rtfmroulette.com/foo/bar', root, 2).
      and_return(new_crawler)

    crawler.crawl_links
  end
  include_context 'crawl specs'
end
