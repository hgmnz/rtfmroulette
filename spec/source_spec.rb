require_relative 'spec_helper'

describe Source, '#readable_content' do
  it 'gives the good part of the content' do
    source = FactoryGirl.build(:source, content: <<-END)
    <div class="main"><p>This part has more text, and no links</p> </div>
    <div class="side"><a href="foo">this is a link</a></div>
    END

    source.readable_content.should include %{<p>This part has more text, and no links</p>}
    source.readable_content.should_not include %{<a href="foo">this is a link</a>}
  end

  it 'converts relative links to absolute' do
    source = FactoryGirl.build(:source, url: "http://rtfmroulette.com", content: <<-END)
    <div class="main"><p>This has a <a href="/foo">link</a></p></div>
    END

    source.readable_content.should include "http://rtfmroulette.com/foo"
  end

  it 'does not raise if the link has no href attribute' do
    source = FactoryGirl.build(:source, content: <<-END)
    <div class="main"><p>This has not a <a>link</a></p></div>
    END

    expect { source.readable_content }.to_not raise_error
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
