class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name, presence: true,
    length: {maximum: Settings.name_length_maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {minimum: Settings.length_minimum,
      maximum: Settings.email_length_maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.length_minimum}
  has_secure_password
end
