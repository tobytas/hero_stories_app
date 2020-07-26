class User < ApplicationRecord

  attr_accessor :activation_token

  has_many      :stories,  dependent: :destroy
  has_many      :comments, dependent: :destroy

  before_save   :email_to_downcase, :create_activation_digest
  before_create :email_to_downcase, :create_activation_digest

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
    return false if activation_digest.nil?
    BCrypt::Password.new(activation_digest).is_password?(token)
  end

  private
    # Sets email to downcase
    def email_to_downcase
      self.email = email.downcase
    end

    # Creates and assigns token and digest for activation
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
