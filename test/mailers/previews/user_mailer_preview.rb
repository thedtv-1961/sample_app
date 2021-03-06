# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.find(105)
    user.activation_token = "EE8SupPSt4bz1ea9jiLmJA"
    UserMailer.account_activation user
  end

  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    user.email = "abc@gmail.com"
    UserMailer.password_reset user
  end
end
