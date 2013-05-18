class User < ActiveRecord::Base

  with_options if: :require_validations? do |user|
    user.validates :email, presence: true, email: true
    user.validates :password, presence: true, length: { minimum: 4 }
  end

  attr_accessor :password

  before_save :encrypt_password

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
