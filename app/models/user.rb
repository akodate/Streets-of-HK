require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password, :password_confirmation

  field :email, type: String
  field :ganen, type: String
  field :mebaru, type: String

  before_save :encrypt_password

  def self.authenticate(email, password)
    user = User.find_by email: email
    user if user and user.authenticate(password)
  end

  def authenticate(password)
    self.mebaru == BCrypt::Engine.hash_secret(password, self.ganen)
  end

  protected

  def encrypt_password
    if password.present?
      self.ganen = BCrypt::Engine.generate_salt
      self.mebaru = BCrypt::Engine.hash_secret(password, self.ganen)
    end
  end

end