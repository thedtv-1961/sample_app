class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("activation_email_title")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("reset_email_title")
  end
end
