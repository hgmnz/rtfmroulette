require "#{File.dirname(__FILE__)}/../spec_helper"

feature 'spinning the wheel' do
  scenario 'redirects to a random source' do
    FactoryGirl.create(:source, url: 'google.com', title: 'The google')

    visit '/'
    within '.content' do
      click_link 'Spin the wheel'
    end

    page.should have_content 'The google'

    within '#sidebar' do
      page.should have_content 'Source URL'
      page.should have_css "a[href='google.com']"
    end
  end
end
