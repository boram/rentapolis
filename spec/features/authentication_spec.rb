require 'spec_helper'

feature 'Sign in' do
  let(:email) { 'boom@example.com' }

  background do
    mock_omniauth email
    visit root_path
  end

  scenario 'Clicking the Facebook sign in link', js: true do
    click_on 'Sign in with Facebook'
    logged_in email
  end
end

feature 'Sign out' do
  background do
    sign_in create(:facebook_user)
  end

  scenario 'Clicking the sign out link' do
    click_on 'Sign out'
    logged_out
  end
end