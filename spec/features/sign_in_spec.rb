feature 'sign up' do
  scenario 'user count increase and personalised welcome message' do
    fill_in_sign_up
    fill_in('password_check', with: 'bobByg' )
    expect{click_button "Sign up"}.to change{User.count}.by 1
    expect(page).to have_content 'Welcome Bob!'
  end

  scenario 'cannot sign up if mismatching passwords' do
    fill_in_sign_up
    click_button "Sign up"
    expect(page).to have_content("Mismatching passwords, please try again.")
    expect(User.all).to be_empty
  end
end
