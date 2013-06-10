class Authentication
  attr_accessor :params, :omniauth

  def initialize(params = {}, omniauth = nil)
    self.params = params
    self.omniauth = omniauth
  end

  def user
    @user ||= if omniauth
      user_from_omniauth
    elsif params
      user_with_password
    end
  end

  def authenticated?
    user.present?
  end

  private

  def user_from_omniauth
    User.where(omniauth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.disable_validations!

      user.provider = omniauth.provider
      user.uid = omniauth.uid
      user.name = omniauth.info.name
      user.email = omniauth.info.email
      user.first_name = omniauth.info.first_name
      user.last_name = omniauth.info.last_name
      user.avatar = omniauth.info.image
      user.location = omniauth.info.location
      user.oauth_token = omniauth.credentials.token
      user.oauth_expires_at = Time.at(omniauth.credentials.expires_at)
      user.save!
    end
  end

  def user_with_password
    if user = User.where(email: params[:email]).first and
       BCrypt::Password.new(user.password_digest) == params[:password]
      user
    else
      nil
    end
  end
end
