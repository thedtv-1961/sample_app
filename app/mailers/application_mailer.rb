class ApplicationMailer < ActionMailer::Base
  default from: ENV["mail_default_sender"]
  layout "mailer"
end
