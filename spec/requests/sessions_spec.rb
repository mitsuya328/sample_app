require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  it "should get new" do
    get login_path
    expect(response).to have_http_status(200)
  end
end
