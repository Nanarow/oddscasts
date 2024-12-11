# Preview all emails at http://localhost:3000/rails/mailers/content_mailer
class ContentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/content_mailer/notify_content_submitted
  def notify_content_submitted
    ContentMailer.notify_content_submitted
  end

end
