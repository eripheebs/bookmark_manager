def create_link
  visit ('/links/new')
  fill_in :url, with: 'www.google.com'
  fill_in :title, with: 'Google'
  fill_in :tags, with: 'searchengine'
  click_button 'Create Link'
end
