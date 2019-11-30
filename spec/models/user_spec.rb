require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
              password: "foobar", password_confirmation: "foobar")
  end

  it "is valid" do
    expect(@user).to be_valid
  end

  it "is invalid without name" do
    @user.name = " "
    expect(@user).not_to be_valid
  end

  it "is invalid without email" do
    @user.email = " "
    expect(@user).not_to be_valid
  end

  it "is invalid with too long name" do
    @user.name = 'a'*51
    expect(@user).not_to be_valid
  end

  it "is invalid with too long address" do
    @user.email = 'a'*255 + '@example.com'
    expect(@user).not_to be_valid
  end

  it "is valid with valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "is invalid with invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "have unique email addresses" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).not_to be_valid
  end

  it "have email addresses as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    expect(@user.reload.email).to eq mixed_case_email.downcase
  end

  it "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).not_to be_valid
  end

  it "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user).not_to be_valid
  end

  it "authenticated? should return false for a user with nil digest" do
    expect(@user.authenticated?(:remember, '')).not_to be true
  end

  it "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum" )
    expect{ @user.destroy }.to change{ Micropost.count }.by(-1)
  end

  it "should follow and unfollow a user" do
    michael = FactoryBot.create(:michael)
    archer = FactoryBot.create(:archer)
    expect(michael.following?(archer)).to be_falsey
    michael.follow(archer)
    expect(michael.following?(archer)).to be_truthy
    expect(archer.followers.include?(michael)).to be_truthy
    michael.unfollow(archer)
    expect(michael.following?(archer)).to be_falsey
  end

  it "feed should have the right posts" do
    michael = FactoryBot.create(:michael)
    post_self = FactoryBot.create(:orange, user: michael)
    archer = FactoryBot.create(:archer)
    post_following = FactoryBot.create(:tau_manifesto, user: archer)
    lana = FactoryBot.create(:lana)
    post_unfollowed = FactoryBot.create(:cat_video, user: lana)
    michael.follow(archer)
    # フォローしているユーザーの投稿を確認
    expect(michael.feed).to include(post_following)
    # 自分自身の投稿を確認
    expect(michael.feed).to include(post_self)
    # フォローしていないユーザーの投稿を確認
    expect(michael.feed).not_to include(post_unfollowed)
  end
end
