feature 'Signing up' do
  scenario '> the user count increases by 1' do
    visit('/sign_up')
    fill_in :username, with: "Anne"
    fill_in :password, with: "Iamallergictocats1"
    fill_in :passwordcheck, with: "Iamallergictocats1"
    expect {click_button "Submit"}.to change{User.count}.by 1
  end
end
