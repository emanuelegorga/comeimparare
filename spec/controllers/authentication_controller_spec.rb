require 'rails_helper'

RSpec.describe V1::AuthenticationController, type: :controller do
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }
    end

    context 'When request is valid' do
      before do
        request.headers.merge!(headers)
        post 'authenticate', params: { user: valid_credentials }
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before do
        request.headers.merge!(headers)
        post 'authenticate', params: { user: invalid_credentials }
      end

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end