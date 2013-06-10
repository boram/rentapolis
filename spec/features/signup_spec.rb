require 'spec_helper'

feature 'Sign up' do
  let(:email) { 'signup-user@example.com' }
  let(:password) { 'asdf1234' }

  background do
    visit new_signup_path
  end

  scenario 'Filling out the sign up form' do
    click_button 'Sign up'

    within '#signup-form' do
      expect(page).to have_css('li.email .inline-errors', text: "can't be blank")
      expect(page).to have_css('li.password .inline-errors', text: "can't be blank")
    end

    within '#signup-form' do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign up'
    end

    # expect(page).to have_content "Logged in as #{email}"
    # expect(page).to have_css 'a#log-out', text: 'Log out'
  end
end