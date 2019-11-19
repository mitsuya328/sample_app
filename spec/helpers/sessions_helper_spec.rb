require 'rails_helper'

describe "SessionsHelper" do
  before do
    @user = FactoryBot.create(:user)
    remember(@user)
  end

  it "current_user returns right user when session is nill" do
    expect(current_user).to eq @user
    expect(is_logged_in?).to be true
  end

  it "current_user returns nil when remember digest wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    expect(current_user). to be_nil
  end
end
