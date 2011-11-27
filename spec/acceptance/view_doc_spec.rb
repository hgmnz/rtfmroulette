require_relative "../spec_helper"

feature 'viewing a doc' do
  scenario 'viewing metadata' do
    source = FactoryGirl.create(:source, url: 'http://postgresql.org/one/two/three', title: 'PostgreSQL')

    visit "/docs/#{source.id}"

    within '#sidebar' do
      page.should have_content 'Source URL'
      page.should have_css "a[href='http://postgresql.org/one/two/three']", text: 'postgresql.org'
    end
  end
end
