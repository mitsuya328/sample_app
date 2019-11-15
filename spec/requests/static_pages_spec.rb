require 'rails_helper'

describe 'StaticPagesController', type: :request do
  it 'should get root' do
    get root_url
    expect(response).to have_http_status(:success)
  end

  it 'should get home' do
    get static_pages_home_url
    expect(response).to have_http_status(:success)
  end

  it 'should get help' do
    get static_pages_help_url
    expect(response).to have_http_status(:success)
  end

  it 'should get about' do
    get static_pages_about_url
    expect(response).to have_http_status(:success)
  end

  it 'should get contact' do
    get static_pages_contact_url
    expect(response).to have_http_status(:success)
  end
end
