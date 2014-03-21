require 'bcrypt'

PASSWORD_RESET_EXPIRES = 4

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password, :password_confirmation

  field :email, type: String
  field :ganen, type: String
  field :mebaru, type: String
  field :code, type: String
  field :expires_at, type: Time

  before_save :set_random_password, :encrypt_password
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, confirmation: true

  before_save :encrypt_password

  def self.authenticate(email, password)
    user = User.find_by email: email
    user if user and user.authenticate(password)
  end

  def authenticate(password)
    self.mebaru == BCrypt::Engine.hash_secret(password, self.ganen)
  end

  def set_password_reset
    self.code = SecureRandom.urlsafe_base64
    set_expiration
  end

  def set_expiration
    self.expires_at = PASSWORD_RESET_EXPIRES.hours.from_now
    self.save!
  end

  protected

  def set_random_password
    if self.mebaru.blank? and password.blank?
      self.ganen = BCrypt::Engine.generate_salt
      self.mebaru = BCrypt::Engine.hash_secret(SecureRandom.base64(32), self.ganen)
    end
  end

  def encrypt_password
    if password.present?
      self.ganen = BCrypt::Engine.generate_salt
      self.mebaru = BCrypt::Engine.hash_secret(password, self.ganen)
    end
  end

end