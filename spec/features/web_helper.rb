def create_link
  visit ('/links/new')
  fill_in :url, with: 'www.google.com'
  fill_in :title, with: 'Google'
  fill_in :tags, with: 'searchengine'
  click_button 'Create Link'
end

def sign_up
  visit('/users/new')
  expect(page.status_code).to eq(200)
  fill_in :username, with: 'Anne'
  fill_in :email, with: 'anne@catsrule.com'
  fill_in :password, with: 'Iamallergictocats1'
  click_button "Submit"
end
