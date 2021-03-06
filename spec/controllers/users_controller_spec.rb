require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:user_params) do
    {
      name: 'Test User',
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password',  
      platform: 'local',
      avatar_url: 'http://example.com'
    }
  end

  describe 'POST /create' do
    context 'when valid request' do
      before do 
        request.headers.merge!(headers)
        post :create, params: { user: user_params }
      end

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before do
        request.headers.merge!(headers)
        post :create, params: { user: { 'email' => nil } }
      end

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Email can't be blank, Name can't be blank, Password digest can't be blank/)
      end
    end
  end
end