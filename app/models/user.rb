class User < ApplicationRecord

  attr_reader   :activation_token
  has_many      :stories
  has_many      :comments

  before_save   { self.email = email.downcase }
  before_create :create_activation_digest

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

  # Returns digest of given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns true if the given token matches the digest
  def authenticated?(token)
    return false if @activation_digest.nil?
    BCrypt::Password.new(@activation_digest).is_password?(token)
  end

  private
    # Creates and assigns token and digest for activation
    def create_activation_digest
      @activation_token  = User.new_token
      @activation_digest = User.digest(activation_token)
    end
end
