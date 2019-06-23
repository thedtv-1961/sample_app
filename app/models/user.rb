class User < ApplicationRecord

  attr_accessor :remember_token

  before_save{email.downcase!}
  validates :name, presence: true,
    length: {maximum: Settings.name_length_maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {
      minimum: Settings.length_minimum,
      maximum: Settings.email_length_maximum
    },
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.length_minimum}
  has_secure_password


  def new_token
    SecureRandom.urlsafe_base64
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end



  def remember
    self.remember_token = new_token
    update_attribute :remember_digest, digest(self.remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attribute :remember_digest, nil
  end

end
