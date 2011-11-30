require "#{File.dirname(__FILE__)}/../spec_helper"

feature 'spinning' do
  scenario 'redirects to a random source' do
    FactoryGirl.create(:source, url: 'http://postgresql.org', title: 'PostgreSQL')

    visit '/'
    within '.content' do
      click_link 'Spin'
    end

    page.should have_content 'PostgreSQL'
  end
end
