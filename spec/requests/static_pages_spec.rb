require 'rails_helper'

describe 'StaticPagesController', type: :request do
  it 'should get root' do
    get root_path
    expect(response).to have_http_status(:success)
  end

  it 'should get help' do
    get help_path
    expect(response).to have_http_status(:success)
  end

  it 'should get about' do
    get about_path
    expect(response).to have_http_status(:success)
  end

  it 'should get contact' do
    get contact_path
    expect(response).to have_http_status(:success)
  end
end
