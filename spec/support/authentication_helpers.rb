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

  def sign_in user, provider = :facebook
    mock_omniauth user.email
    visit omniauth_callback_path(provider)
  end
end
