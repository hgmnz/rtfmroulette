require_relative '../spec_helper'

describe Parser::RubydocOrg do
  let(:raw_content) do
    <<-END
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <body id="top" class="class">
      <div>Should not appear</div>
      <div id="documentation">
        <div>This is the main content</div>
      </div>
      <div>Should not appear</div>
    </body>
    </html>
    END
  end

  it 'extracts the documentation div' do
    source = FactoryGirl.build(:source, url: 'http://ruby-doc.org', content: raw_content)
    parser = Parser::RubydocOrg.new(source)

    parser.readable_content.should include %{<div>This is the main content</div>}
    parser.readable_content.should_not include %{<div>Should not appear</div>}
  end
end
