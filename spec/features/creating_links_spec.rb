feature 'Creating links' do
  scenario '> should add link to database' do
    create_link

    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content('Google')
    end
  end
end
