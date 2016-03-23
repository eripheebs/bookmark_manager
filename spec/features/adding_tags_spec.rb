feature 'Adding Tags' do
  scenario '> adds tag to link' do
    create_link
    link = Link.first
    expect(link.tags.map(&:tag)).to include('searchengine')
  end

  scenario '> adds multiple tags to link' do
    visit ('/links/new')
    fill_in :url, with: 'www.google.com'
    fill_in :title, with: 'Google'
    fill_in :tags, with: 'searchengine, awesome, useful'
    click_button 'Create Link'
    link = Link.first
    expect(link.tags.map(&:tag)).to include('awesome')
    expect(link.tags.map(&:tag)).to include('useful')
  end
end
