feature 'Adding Tags' do
  scenario '> adds tag to link' do
    create_link
    link = Link.first
    expect(link.tags.map(&:tag)).to include('searchengine')
  end
end
