require 'spec_helper'

feature 'Log in', js: true do
  let!(:user) { create :user }

  background do
    visit root_path
  end

  scenario 'using the log in form' do
    within '#login-form' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    expect(page).to have_content "Logged in as #{user.email}"
    expect(page).to have_css 'a#log-out', text: 'Log out'
  end
end

# feature 'Facebook sign in' do
#   let(:email) { 'boom@example.com' }

#   background do
#     mock_omniauth email
#     visit root_path
#   end

#   scenario 'clicking the Facebook sign in link', js: true do
#     click_on 'Sign in with Facebook'
#     logged_in email
#   end
# end

feature 'Log out', js: true do
  background do
    log_in create(:user)
  end

  scenario 'clicking the log out link' do
    click_on 'Log out'
    expect(page).to have_css('#login-form')
  end
end