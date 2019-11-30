require 'rails_helper'

RSpec.describe "Following", type: :system do
  let!(:user){ FactoryBot.create(:michael) }
  let!(:other_user){ FactoryBot.create(:archer) }
  let!(:relationship){ Relationship.create(follower: user, followed: other_user)}
  let!(:other_relationship){ Relationship.create(follower: other_user, followed: user)}
  before do
    log_in_as(user)
  end

  it "Following page" do
    visit following_user_path(user)
    expect(user.following).not_to be_empty
    expect(page).to have_content user.following.count.to_s
    expect(page).to have_link href: user_path(other_user)
  end

  it "followers page" do
    visit followers_user_path(user)
    expect(user.followers).not_to be_empty
    expect(page).to have_content user.followers.count.to_s
    expect(page).to have_link href: user_path(other_user)
  end
end
