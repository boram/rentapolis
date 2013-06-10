module AuthenticationHelpers
  def mock_omniauth email, provider = :facebook
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock provider,
      uid: "12345",
      info: { email: email },
      credentials: {
        token: 'ABCD1234',
        expires_at: 2.weeks.from_now.to_i
      }
  end

  def log_in user, options = {}
    visit root_path

    if provider = options[:with]
      mock_omniauth user.email, provider
      visit api_omniauth_callback_path(provider)
    else
      within '#login-form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end
    end
  end
end
