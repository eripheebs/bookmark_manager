feature 'Filter links by tags' do

  before(:each) do
    Link.create(url: 'http://google.com', title: 'Google', tags: [Tag.first_or_create(tag: 'searchengine')])
    Link.create(url: 'http://bbc.co.uk', title: 'BBC News', tags: [Tag.first_or_create(tag: 'news')])
    Link.create(url: 'http://zombo.com', title: 'Zomyo', tags: [Tag.first_or_create(tag: 'bubbles')])
    Link.create(url: 'http://yahoo.com', title: 'Yahoo', tags: [Tag.first_or_create(tag: 'searchengine')])
  end


  scenario '> can show links with tag on separate page' do
    visit '/links/tags/searchengine'

    expect(page.status_code).to eq(200)

    within 'ul#links' do
      expect(page).to have_content('Google')
      expect(page).to_not have_content('BBC News')
      expect(page).to_not have_content('Zomyo')
      expect(page).to have_content('Yahoo')
    end
  end
end
