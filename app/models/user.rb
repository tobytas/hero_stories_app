class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w.+-]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i.freeze
  private_constant :VALID_EMAIL_REGEX

  validates :name,     presence:   true,
                       length:     { maximum: 50 }

  validates :email,    presence:   true,
                       length:     { maximum: 255 },
                       format:     { with: VALID_EMAIL_REGEX },
                       uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length:     { minimum: 6 }

  before_save { self.email = email.downcase }
end
