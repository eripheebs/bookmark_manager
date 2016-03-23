feature 'Creating links' do
  scenario '> should add link to database' do
    visit ('/links/new')
    fill_in :url, with: 'www.google.com'
    fill_in :title, with: 'Google'
    click_button 'Create Link'

    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content('Google')
    end
  end
end
