require_relative 'spec_helper'

describe Root, '#uri' do
  it 'gives the parsed url' do
    root = FactoryGirl.build(:root, url: 'http://rtfmroulette.com')
    root.uri.scheme.should == 'http'
    root.uri.host.should == 'rtfmroulette.com'
  end
end
