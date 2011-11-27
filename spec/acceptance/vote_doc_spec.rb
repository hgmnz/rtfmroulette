require_relative '../spec_helper'

feature 'voting on docs', js: true do
  scenario 'upvoting a doc' do
    root   = FactoryGirl.create(:root, topic: 'PostgreSQL')
    source = FactoryGirl.create(:source, url:   'http://postgresql.org/one/two/three',
                                         title: 'PostgreSQL',
                                         root:   root)

    visit "/docs/#{source.id}"


    within '#sidebar' do
      click_link 'up-vote'
    end

    page.should_not have_css '.votes a'
  end
end
