class ContentMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.content_mailer.notify_content_submitted.subject
  #
  default from: "from@example.com"
  def notify_content_submitted
    @greeting = "Hi"
    mail to: "to@example.org", subject: "Notify content submitted"
  end
end
