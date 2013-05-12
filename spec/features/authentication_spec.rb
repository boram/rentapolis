require 'spec_helper'

feature 'Sign in' do
  let(:email) { 'boom@example.com' }

  background do
    mock_omniauth email
    visit root_path
  end

  scenario 'Clicking the Facebook sign in link', js: true do
    click_on 'Sign in with Facebook'

    expect(page).to have_content "Signed in as #{email}"
    expect(page).to have_css 'a#sign-out', text: 'Sign out'
  end
end

feature 'Sign out' do
  background do
    sign_in create(:facebook_user)
  end

  scenario 'Clicking the sign out link' do
    click_on 'Sign out'
    expect(page).to have_css 'a#sign-in', text: 'Sign in with Facebook'
  end
end