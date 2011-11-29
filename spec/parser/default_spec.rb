require_relative '../spec_helper'

describe Parser::Default do
  it 'gives the good part of the content' do
    source = FactoryGirl.build(:source, content: <<-END)
    <div class="main"><p>This part has more text, and no links</p> </div>
    <div class="side"><a href="foo">this is a link</a></div>
    END

    parser = Parser::Default.new(source)

    parser.readable_content.should include %{<p>This part has more text, and no links</p>}
    parser.readable_content.should_not include %{<a href="foo">this is a link</a>}
  end

  it 'converts relative links to absolute' do
    source = FactoryGirl.build(:source, url: "http://rtfmroulette.com", content: <<-END)
    <div class="main"><p>This has a <a href="/foo">link</a></p></div>
    END

    parser = Parser::Default.new(source)

    parser.readable_content.should include "http://rtfmroulette.com/foo"
  end

  it 'does not raise if the link has no href attribute' do
    source = FactoryGirl.build(:source, content: <<-END)
    <div class="main"><p>This has not a <a>link</a></p></div>
    END

    parser = Parser::Default.new(source)

    expect { parser.readable_content }.to_not raise_error
  end

  it 'does not raise if the link is an invalid uri' do
    source = FactoryGirl.build(:source, content: <<-END)
    <div class="main"><p>This has not a <a href="http://string,...">link</a></p></div>
    END

    parser = Parser::Default.new(source)
    expect { parser.readable_content }.to_not raise_error
  end
end
