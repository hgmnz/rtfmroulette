require_relative 'spec_helper'

describe Source, '#readable_content' do
  it 'delegates parsing to the default parser' do
    parser = double(:parser, readable_content: 'hi')
    Parser::Default.stub!(new: parser)
    source = FactoryGirl.build(:source)
    source.stub!(parser: parser)

    parser.should_receive(:readable_content)
    source.readable_content.should == 'hi'
  end
end

describe Source, '.random' do
  it 'fetches a different record every time' do
    3.times { FactoryGirl.create(:source) }
    3.times.map { Source.random }.uniq.size.should >= 1
  end
end

describe Source, '#host' do
  it 'gives the host portion of the url' do
    source = FactoryGirl.build(:source, url: 'http://postgresql.org/one/two')
    source.host.should == 'postgresql.org'
  end
end

describe Source, '#topic' do
  it "delegates to it's root" do
    root   = FactoryGirl.create(:root, topic: 'foo')
    source = FactoryGirl.build(:source, root: root)

    source.topic.should == 'foo'
  end
end

describe Source, '#upvote' do
  it 'increments upvotes by one' do
    source = FactoryGirl.build(:source, upvotes: 4)
    source.upvote

    source.reload.upvotes.should == 5
  end
end

describe Source, '#downvote' do
  it 'increments downvotes by one' do
    source = FactoryGirl.build(:source, downvotes: 4)
    source.downvote

    source.reload.downvotes.should == 5
  end
end
