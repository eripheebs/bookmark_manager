feature 'Signing up' do
  scenario '> the user count increases by 1' do
    expect {sign_up}.to change{User.count}.by 1
    expect(page).to have_content("Welcome, Anne")
    expect(User.first.email).to eq("anne@catsrule.com")
  end
end
