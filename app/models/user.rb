class User < ApplicationRecord
  before_save{email.downcase!}

  attr_accessor :remember_token

  validates :name, presence: true,
    length: {maximum: Settings.name_length_maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {minimum: Settings.length_minimum,
             maximum: Settings.email_length_maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: Settings.length_minimum},
    allow_nil: true
  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? min_cost : cost
      BCrypt::Password.create(string, cost: cost)
    end

    private
    def min_cost
      BCrypt::Engine::MIN_COST
    end

    def cost
      BCrypt::Engine.cost
    end
  end
end
