class User < ActiveRecord::Base

  with_options if: :require_validations? do |user|
    user.validates :email, presence: true
    user.validates :password, presence: true
  end

  attr_accessor :password

  before_save :encrypt_password

  def self.authenticate email, password
    user = where(email: email).first
    if user and BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.disable_validations!

      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.avatar = auth.info.image
      user.location = auth.info.location
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def disable_validations!
    @disable_validations = true
  end

  def require_validations?
    !@disable_validations
  end

  private

  def encrypt_password
    self.password_digest = BCrypt::Password.create(password)
  end
end
