feature 'Homepage' do
  scenario '> should have list of links' do
    Link.create(url: 'http://www.google.com', title: 'Google')
    visit('/links')
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Google')
    end
  end
end

feature "Add Link button" do
  scenario '> should bring to add links page' do
    visit('/links')
    click_button 'Add Link'
    expect(current_path).to eq '/links/new'
  end

end
