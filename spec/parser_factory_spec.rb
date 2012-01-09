require_relative './spec_helper'

describe ParserFactory do
  it 'uses the default parser if no strategy is available' do
    source = FactoryGirl.build(:source)
    parser = ParserFactory.create_parser(source)
    parser.should be_kind_of Parser::Default
  end

  it 'uses a parser based on the host name if available' do
    class Parser::RubydocOrg; end
    source = FactoryGirl.build(:source, url: 'http://ruby-doc.org/core-1.9.3/')
    parser = ParserFactory.create_parser(source)
    parser.should be_kind_of Parser::RubydocOrg
  end
end
