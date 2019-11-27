require 'rails_helper'

RSpec.describe "UsersIndex", type: :system do

  let(:admin){ FactoryBot.create(:michael) }
  let(:non_admin){ FactoryBot.create(:archer) }
  before(:all) { 50.times { FactoryBot.create(:user) } }
  after(:all)  { User.delete_all }

  it "including pagination　and delete links",:js => true do
    log_in_as(admin)
    visit users_path
    expect(page).to have_title 'All users'
    first_page_of_users = User.paginate(page: 1)
    expect(page).to have_selector 'div.pagination', count: 2
    first_page_of_users.each do |user|
      expect(page).to have_link user.name, href: user_path(user)
      unless user == admin
        expect(page).to have_link 'delete', href: user_path(user)
      end
    end
    expect do
      click_link 'delete',match: :first
      page.accept_confirm
      sleep 0.1.second
    end.to change{ User.count }.by(-1)
  end

  it "index as non-admin" do
    log_in_as(non_admin)
    visit users_path
    expect(page).not_to have_link 'delete'
  end
end
