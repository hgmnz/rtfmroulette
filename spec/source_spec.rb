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
