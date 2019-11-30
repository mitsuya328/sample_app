require 'rails_helper'

RSpec.describe "RelationshipsController", type: :request do
  let!(:user){ FactoryBot.create(:michael) }
  let!(:other_user){ FactoryBot.create(:archer) }
  let!(:relationship){ Relationship.create(follower: user, followed: other_user) }

  it "create should require logged-in user" do
    expect{ post relationships_path }.not_to change{ Relationship.count }
    expect(response).to redirect_to login_url
  end

  it "destroy should require logged-in user" do
    expect{ delete relationship_path(relationship) }.not_to change{ Relationship.count }
    expect(response).to redirect_to login_url
  end

  describe "when logged in" do
    before{ log_in_as(user) }

    it "should Unfollow and follow a user the standard way" do
      expect{
        delete relationship_path(relationship)
      }.to change{ Relationship.count }.by(-1)
      expect{
        post relationships_path, params:{ followed_id: other_user.id }
      }.to change{ Relationship.count }.by(1)
    end

    it "should Unfollow and follow a user with Ajax" do
      expect{
        delete relationship_path(relationship), xhr: true
      }.to change{ Relationship.count }.by(-1)
      expect{
        post relationships_path, xhr: true, params:{ followed_id: other_user.id }
      }.to change{ Relationship.count }.by(1)
    end
  end
end
