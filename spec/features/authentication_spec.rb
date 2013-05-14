require 'spec_helper'

feature 'Sign in' do
  let(:user) { create :user }

  background do
    visit signin_path
  end

  scenario 'filling out the sign in form' do
    within '#signin-form' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end
    logged_in user.email
  end
end

feature 'Facebook sign in' do
  let(:email) { 'boom@example.com' }

  background do
    mock_omniauth email
    visit root_path
  end

  scenario 'clicking the Facebook sign in link', js: true do
    click_on 'Sign in with Facebook'
    logged_in email
  end
end

feature 'Sign out' do
  background do
    sign_in create(:user)
  end

  scenario 'clicking the sign out link' do
    click_on 'Sign out'
    logged_out
  end
end