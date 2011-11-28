require "#{File.dirname(__FILE__)}/../spec_helper"

feature 'spinning' do
  scenario 'redirects to a random source' do
    FactoryGirl.create(:source, url: 'google.com', title: 'The google')

    visit '/'
    within '.content' do
      click_link 'Spin'
    end

    page.should have_content 'The google'
  end
end
