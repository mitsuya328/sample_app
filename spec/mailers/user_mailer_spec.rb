require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user){ FactoryBot.create(:michael) }

  it "account_activation" do
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    expect(mail.subject).to eq "Account activation"
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq ["noreply@example.com"]
    expect(mail.body.encoded).to have_content user.name
    expect(mail.body.encoded).to have_content user.activation_token
    expect(mail.body.encoded).to have_content CGI.escape(user.email)
  end

  it "password_reset" do
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    expect(mail.subject).to eq "Password reset"
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq ["noreply@example.com"]
    expect(mail.body.encoded).to have_content user.reset_token
    expect(mail.body.encoded).to have_content CGI.escape(user.email)
  end
end
