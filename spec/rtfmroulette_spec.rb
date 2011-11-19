require "#{File.dirname(__FILE__)}/spec_helper"

describe 'main application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  it 'shows the default index page' do
    get '/'
    last_response.should be_ok
  end
end
