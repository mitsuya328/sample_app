require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user){ FactoryBot.create(:michael) }
  let(:other_user){ FactoryBot.create(:archer) }
  let(:relationship){ Relationship.new(follower_id: user.id,
                                   followed_id: other_user.id) }

  it "should be valid" do
    expect(relationship.valid?).to be_truthy
  end

  it "should require a follower_id" do
    relationship.follower_id = nil
    expect(relationship.valid?).to be_falsey
  end

  it "should require a followed_id" do
    relationship.followed_id = nil
    expect(relationship.valid?).to be_falsey
  end
end
