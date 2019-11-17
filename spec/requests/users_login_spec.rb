require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  it "with invalid information" do
    get login_path
    expect(response).to render_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    expect(response).to render_template 'sessions/new'
    expect(flash).to be_present
    get root_path
    expect(flash).not_to be_present
  end
end
