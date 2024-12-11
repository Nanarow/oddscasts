require "rails_helper"

RSpec.describe ContentMailer, type: :mailer do
  describe "notify_content_submitted" do
    let(:mail) { ContentMailer.notify_content_submitted }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify content submitted")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
