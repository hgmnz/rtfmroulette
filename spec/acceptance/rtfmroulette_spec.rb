require "#{File.dirname(__FILE__)}/../spec_helper"

feature 'the home page' do
  scenario 'renders the home page fine', type: :request do
    visit '/'
    page.body.should have_css 'a', text: "Spin the wheel"
  end
end
