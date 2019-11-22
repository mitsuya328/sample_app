require 'rails_helper'

RSpec.describe "UsersIndex", type: :system do

  let(:user) { FactoryBot.create(:michael) }
  before(:all) { 30.times { FactoryBot.create(:user) } }
  after(:all)  { User.delete_all }

  it "including pagination" do
    log_in_as(user)
    visit users_path
    expect(page).to have_title 'All users'
    expect(page).to have_selector 'div.pagination', count: 2
    User.paginate(page: 1).each do |user|
      expect(page).to have_link user.name, href: user_path(user)
    end
  end
end
